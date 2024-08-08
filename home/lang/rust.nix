{ config, lib, pkgs, ... }:

{
  home.sessionVariables.CARGO_HOME = "${config.xdg.dataHome}/cargo";
  xdg.dataFile."cargo/config.toml".text = ''
    [build]
    rustc-wrapper = "${lib.getExe pkgs.sccache}"
  '';

  ethy.ftplugin.rust = {
    packages = with pkgs; [
      rust-analyzer
      rustfmt
      clippy
      cargo
      sccache
    ];
    setup.server = "rust_analyzer";
    plugins = [
      {
        "1" = "vxpm/ferris.nvim";
        opts = {};
        config = ''r!function(opts)
          require 'ferris'.setup(opts)

          local nmap = require 'keybinds'.bufmap 'nv'
          local function cmap(key)
            return function(fn)
              nmap('<localleader>' .. key)(require('ferris.methods.' .. fn))
            end
          end

          cmap 'e' 'expand_macro'
          cmap 'hir' 'view_hir'
          cmap 'mir' 'view_mir'
          cmap 'mem' 'view_memory_layout'
          cmap 's' 'view_syntax_tree'
          cmap 'c' 'open_cargo_toml'
          cmap 'r' 'reload_workspace'
        end'';
      }
      {
        "1" = "Saecki/crates.nvim";
        ft = "toml";
        opts = {
          completion = {
            cmp.enabled = true;
            crates.enabled = true;
          };
          lsp = {
            enabled = true;
            actions = true;
            completion = true;
            hover = true;
            on_attach = ''r!function()
              local crates = require 'crates'
              local nmap = require 'keybinds'.bufmap 'nv'
              local function cmap(key, fn)
                nmap('<localleader>' .. key)(fn)
              end

              cmap('u', crates.update_crate)
              cmap('c', crates.show_crate_popup)
              cmap('v', crates.show_versions_popup)
              cmap('f', crates.show_features_popup)
              cmap('d', crates.show_dependencies_popup)
              cmap('l', crates.open_lib_rs)
              cmap('r', crates.open_repository)
              cmap('o', crates.open_documentation)
            end'';
          };
        };
      }
      {
        "1" = "rose-pine/neovim";
        name = "rose-pine";
      }
    ];
    colourscheme = "rose-pine";
  };
}
