# Tree-Sitter Grammar for YTT annotations

This repository provides a Tree-Sitter grammar for [YTT](https://carvel.dev/ytt) (YAML Templating Tool) annotations.

<p align="center">
  <a href="hl-on.png" target="_blank"><img src="hl-on.png" alt="syntax highlighting enabled" width="800" style="max-width: 100%;"></a>
  <a href="hl-off.png" target="_blank"><img src="hl-off.png" alt="syntax highlighting disabled" width="800" style="max-width: 100%;"></a>
</p>

## Installation

This particular configuration is for AstroNvim4,
but it should be similar for other Neovim setups that support Tree-Sitter.

When in doubt, refer to the [nvim-treesitter documentation](https://github.com/nvim-treesitter/nvim-treesitter#adding-custom-languages).

### Install the parser and queries

```lua
-- Configure custom parser for YTT annotations grammar
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.ytt_annotation = {
  install_info = {
    url = "https://github.com/zebradil/tree-sitter-ytt_annotation",
    branch = "main",
    files = { "src/parser.c" },
  },
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Make sure it is installed
        -- Alternatively, you can run :TSInstall ytt_annotation
        "ytt_annotation",
      },
    },
  },
  -- Install syntax highlighting queries
  {
    "zebradil/tree-sitter-ytt_annotation",
    lazy = false,
  },
}
```

### Configure language injection

Now you can inject YTT annotations into YAML files.
Add the following queries to your `nvim/after/queries/yaml/injections.scm` file:

```query
((comment) @injection.content
  (#lua-match? @injection.content "^#@%a")
  (#offset! @injection.content 0 2 0 0)  ; remove leading "#@"
  (#set! injection.language "ytt_annotation"))
```

## Starlark

Most likely you'd also want to add Starlark injections.

Make sure you have the Starlark parser installed: `:TSInstall starlark`

Then add the following to your `nvim/after/queries/yaml/injections.scm` file:

```query
((comment) @injection.content
  (#lua-match? @injection.content "^#@ ")
  (#offset! @injection.content 0 3 0 0)  ; remove leading "#@"
  (#set! injection.language "starlark"))
```

This will provide a basic syntax highlighting for Starlark code in YTT templates.
