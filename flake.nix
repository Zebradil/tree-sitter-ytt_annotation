{
  description = "Tree-sitter grammar for ytt_annotation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    {
      overlays.default = final: prev: {
        tree-sitter-ytt_annotation = final.tree-sitter.buildGrammar {
          language = "ytt_annotation";
          version = "0.1.0";
          src = self;
        };
        vimPlugins = prev.vimPlugins // {
          tree-sitter-ytt_annotation-nvim =
            let
              base = final.vimPlugins.nvim-treesitter.grammarToPlugin final.tree-sitter-ytt_annotation;
            in
            base.overrideAttrs (old: {
              dependencies = (old.dependencies or [ ]) ++ [
                final.vimPlugins.nvim-treesitter-parsers.yaml
                final.vimPlugins.nvim-treesitter-parsers.starlark
              ];
              # Append the after/ directory for YAML injection queries
              postInstall = (old.postInstall or "") + ''
                mkdir -p $out/after/queries/yaml
                cp ${self}/after/queries/yaml/injections.scm \
                   $out/after/queries/yaml/injections.scm
              '';
            });
        };
      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ self.overlays.default ];
        };
      in
      {
        packages = {
          default = pkgs.vimPlugins.tree-sitter-ytt_annotation-nvim;
          grammar = pkgs.tree-sitter-ytt_annotation;
          nvim-plugin = pkgs.vimPlugins.tree-sitter-ytt_annotation-nvim;
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            tree-sitter
            nodejs
          ];
        };
      }
    );
}
