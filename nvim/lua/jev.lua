-- Ask Jev (TypeSafe.ai) which of the blog's existing tags apply to the post in
-- the current buffer. Companion to ~/workspace/blog/scripts/tag_suggest_poc.py
-- - that script's docstring has the full design rationale (why one Noul
-- question per *existing* tag rather than a single Choice question, and the
-- observed precision/recall tradeoff of the generic criteria template used
-- below); this is the same request, fired from the editor instead of the
-- shell, so results should read the same way.
--
-- Requires: plenary.nvim (already a dependency, see plugins.lua) for the
-- async HTTP client, and TYPESAFE_API_KEY set in the environment nvim was
-- launched from.
local jev_blog_posts_dir = vim.fn.expand('~/workspace/blog/src/data/blog-posts')
local jev_api_url = 'https://api.typesafe.ai/v1/systemone'
local jev_model = 'jev-latest'

-- Raw tag strings listed under a `tags:\n  - foo\n  - bar` YAML block
-- anywhere in `lines` (single-level list items only - that's all this
-- blog's frontmatter ever uses). Requires whitespace between the `-` and
-- the item text so the frontmatter's closing `---` delimiter (itself
-- dash-prefixed) doesn't get mistaken for a one-character tag "--".
local function jev_parse_tag_list(lines)
  local tags = {}
  local in_tags = false
  for _, line in ipairs(lines) do
    if in_tags then
      local tag = line:match('^%s*-%s+(.-)%s*$')
      if tag and tag ~= '' then
        table.insert(tags, (tag:gsub("^['\"]", ''):gsub("['\"]$", '')))
      else
        in_tags = false
      end
    end
    if line == 'tags:' then
      in_tags = true
    end
  end
  return tags
end

-- Every distinct tag already used across the blog's posts, case-folded (the
-- real data has inconsistent casing for the same tag, e.g. `javascript` /
-- `JavaScript`) with a canonical display casing chosen as whichever variant
-- is most common. Mirrors load_tag_vocabulary() in tag_suggest_poc.py; kept
-- as separate Lua code rather than shelling out to Python so the editor
-- command has no dependency on the mise-managed Python environment.
local function jev_load_tag_vocabulary()
  local variant_counts = {} -- fold -> {variant -> count}
  local paths = vim.fn.glob(jev_blog_posts_dir .. '/*.md', true, true)
  vim.list_extend(paths, vim.fn.glob(jev_blog_posts_dir .. '/*.mdx', true, true))

  for _, path in ipairs(paths) do
    for _, tag in ipairs(jev_parse_tag_list(vim.fn.readfile(path))) do
      local fold = tag:lower()
      variant_counts[fold] = variant_counts[fold] or {}
      variant_counts[fold][tag] = (variant_counts[fold][tag] or 0) + 1
    end
  end

  local canonical = {} -- fold -> display name
  for fold, variants in pairs(variant_counts) do
    local best_variant, best_count = nil, -1
    for variant, count in pairs(variants) do
      if count > best_count then
        best_variant, best_count = variant, count
      end
    end
    canonical[fold] = best_variant
  end
  return canonical
end

-- Title, body, and the post's own already-applied tags (case-folded), from
-- the current buffer. Every other Astro frontmatter field (slug,
-- publishDate, description, draft, thumbnail) is deliberately ignored, per
-- the same "keep known/exact data in code, ask the model only what needs
-- judgment" reasoning as the Python POC.
local function jev_parse_current_buffer()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  if lines[1] ~= '---' then
    return { title = '', body = table.concat(lines, '\n'), existing_tags = {} }
  end

  local close_at = nil
  for i = 2, #lines do
    if lines[i] == '---' then
      close_at = i
      break
    end
  end
  if not close_at then
    return { title = '', body = table.concat(lines, '\n'), existing_tags = {} }
  end

  local frontmatter = vim.list_extend({}, lines, 1, close_at)
  local title = ''
  for _, line in ipairs(frontmatter) do
    local match = line:match('^title:%s*(.-)%s*$')
    if match then
      title = match:gsub("^['\"]", ''):gsub("['\"]$", '')
      break
    end
  end

  local existing_tags = {}
  for _, tag in ipairs(jev_parse_tag_list(frontmatter)) do
    existing_tags[tag:lower()] = true
  end

  local body_lines = vim.list_extend({}, lines, close_at + 1)
  return { title = title, body = table.concat(body_lines, '\n'), existing_tags = existing_tags }
end

local function jev_build_questions(tag_vocabulary)
  local questions = {}
  for fold, display_name in pairs(tag_vocabulary) do
    questions[fold] = {
      type = 'noul',
      instructions = string.format('Does this blog post relate to the topic "%s"?', display_name),
      criteria = {
        ['true'] = string.format('The post is meaningfully about %s', display_name),
        ['false'] = string.format('The post is not about %s', display_name),
      },
    }
  end
  return questions
end

local function jev_show_results(title, tag_vocabulary, existing_tags, decoded)
  local scored = {}
  for fold, display_name in pairs(tag_vocabulary) do
    table.insert(scored, { display_name = display_name, fold = fold, probability = decoded.answers[fold].noul })
  end
  table.sort(scored, function(a, b) return a.probability > b.probability end)

  local result_lines = { string.format('Jev tag suggestions for: %s', title), '' }
  for _, entry in ipairs(scored) do
    local marker = existing_tags[entry.fold] and '  (already tagged)' or ''
    table.insert(result_lines, string.format('%.3f  %s%s', entry.probability, entry.display_name, marker))
  end
  table.insert(result_lines, '')
  table.insert(result_lines, string.format('usage: %d in / %d out tokens', decoded.usage.input_tokens, decoded.usage.output_tokens))

  local result_buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(result_buf, 0, -1, false, result_lines)
  vim.bo[result_buf].modifiable = false
  vim.bo[result_buf].buftype = 'nofile'
  vim.bo[result_buf].bufhidden = 'wipe'
  vim.cmd('vsplit')
  vim.api.nvim_win_set_buf(0, result_buf)
  vim.keymap.set('n', 'q', '<CMD>close<CR>', { buffer = result_buf, silent = true })
end

local function jev_suggest_tags()
  local buf_path = vim.api.nvim_buf_get_name(0)
  if not buf_path:find(jev_blog_posts_dir, 1, true) then
    vim.notify('JevSuggestTags: current buffer is not under ' .. jev_blog_posts_dir, vim.log.levels.WARN)
    return
  end

  local api_key = vim.env.TYPESAFE_API_KEY
  if not api_key or api_key == '' then
    vim.notify('JevSuggestTags: TYPESAFE_API_KEY is not set', vim.log.levels.ERROR)
    return
  end

  local ok_curl, curl = pcall(require, 'plenary.curl')
  if not ok_curl then
    vim.notify('JevSuggestTags: plenary.nvim is required', vim.log.levels.ERROR)
    return
  end

  local tag_vocabulary = jev_load_tag_vocabulary()
  if vim.tbl_isempty(tag_vocabulary) then
    vim.notify('JevSuggestTags: found no existing tags under ' .. jev_blog_posts_dir, vim.log.levels.ERROR)
    return
  end

  local post = jev_parse_current_buffer()
  local questions = jev_build_questions(tag_vocabulary)

  -- No "asking Jev..." vim.notify here on purpose: with cmdheight=0 (see
  -- options.lua), any notify/echo forces a blocking "Press ENTER to
  -- continue" prompt until dismissed, which held up the results split from
  -- becoming visible even though it had already finished rendering.
  curl.post(jev_api_url, {
    headers = {
      ['Authorization'] = 'Bearer ' .. api_key,
      ['Content-Type'] = 'application/json',
    },
    body = vim.json.encode({
      state = { title = post.title, body = post.body },
      model = jev_model,
      questions = questions,
    }),
    callback = vim.schedule_wrap(function(response)
      if response.status ~= 200 then
        vim.notify(string.format('JevSuggestTags: API error %d: %s', response.status, response.body), vim.log.levels.ERROR)
        return
      end

      local ok_decode, decoded = pcall(vim.json.decode, response.body)
      if not ok_decode then
        vim.notify('JevSuggestTags: could not parse API response', vim.log.levels.ERROR)
        return
      end

      jev_show_results(post.title, tag_vocabulary, post.existing_tags, decoded)
    end),
  })
end

vim.api.nvim_create_user_command('JevSuggestTags', jev_suggest_tags, {
  desc = 'ask Jev which existing blog tags apply to this post',
})
