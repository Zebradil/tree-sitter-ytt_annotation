; extends
; vim: set tabstop=2 shiftwidth=2 expandtab:

; START: ytt

((comment) @injection.content
  (#lua-match? @injection.content "^#@ ")
  (#offset! @injection.content 0 3 0 0)  ; remove leading "#@"
  (#set! injection.language "starlark"))

; ytt overlays
((comment) @injection.content
  (#lua-match? @injection.content "^#@%a")
  (#offset! @injection.content 0 2 0 0)  ; remove leading "#@"
  (#set! injection.language "ytt_annotation"))

; END: ytt
