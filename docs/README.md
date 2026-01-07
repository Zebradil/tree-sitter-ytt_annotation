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
        -- Starlark grammar is optional but recommended for full syntax highlighting
        "starlark",
      },
    },
  },
  -- Install syntax highlighting and language injection queries
  {
    "zebradil/tree-sitter-ytt_annotation",
    lazy = false,
  },
}
```
