vim.lsp.start({
  name = 'ballerina-lsp',
  cmd = { 'bal', 'start-language-server' },
  root_dir = vim.fs.dirname(vim.fs.find({'Ballerina.toml'}, {upward = true})[1])
})
