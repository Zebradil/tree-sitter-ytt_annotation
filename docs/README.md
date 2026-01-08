# YTT Annotation grammar for Tree-Sitter

This repository provides a [YTT](https://carvel.dev/ytt) (YAML Templating Tool) annotation grammar for [tree-sitter](https://tree-sitter.github.io/tree-sitter/), enabling syntax highlighting and parsing of YTT annotations within YAML files. It can be installed as a Neovim plugin with almost no configuration.

## Features

- Syntax highlighting for YTT annotations and Starlark code in YAML files.
- Easy integration with Neovim via the `nvim-treesitter` plugin.

<p align="center">
  <a href="hl-on.png" target="_blank"><img src="hl-on.png" alt="syntax highlighting enabled" width="800" style="max-width: 100%;"></a>
  <a href="hl-off.png" target="_blank"><img src="hl-off.png" alt="syntax highlighting disabled" width="800" style="max-width: 100%;"></a>
</p>

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "zebradil/tree-sitter-ytt_annotation",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  -- tree-sitter language injection queries aren't always properly loaded
  -- during lazy loading, so we disable it here
  lazy = false,
}
```
