;; Copied from nvim 0.12 bundled runtime/queries/markdown/injections.scm
;;
;; This overrides nvim-treesitter's injections.scm, which uses a custom predicate
;; `#set-lang-from-info-string!` that returns nil nodes under nvim 0.12's updated
;; treesitter match API, crashing with:
;;   "attempt to call method 'range' (a nil value)" at languagetree.lua:215
;;
;; The bundled version uses the standard @injection.language capture instead, which
;; works correctly with nvim 0.12.
(fenced_code_block
  (info_string
    (language) @injection.language)
  (code_fence_content) @injection.content)

((html_block) @injection.content
  (#set! injection.language "html")
  (#set! injection.combined)
  (#set! injection.include-children))

((minus_metadata) @injection.content
  (#set! injection.language "yaml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

((plus_metadata) @injection.content
  (#set! injection.language "toml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

([
  (inline)
  (pipe_table_cell)
] @injection.content
  (#set! injection.language "markdown_inline"))
