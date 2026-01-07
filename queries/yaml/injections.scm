; extends

((comment) @injection.content
  (#lua-match? @injection.content "^#@ ")
  (#offset! @injection.content 0 3 0 0)
  (#set! injection.language "starlark"))

((comment) @injection.content
  (#lua-match? @injection.content "^#@%a")
  (#offset! @injection.content 0 2 0 0)
  (#set! injection.language "ytt_annotation"))
