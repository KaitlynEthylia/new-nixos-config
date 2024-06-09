{ config, ... }:

{
  config.programs.niri = {
    enable = true;
    settings = {
      input.keyboard.xkb.layout = "gb";
      window-rules = [
        {
          matches = [];
          geometry-corner-radius = let radius = 12.0; in {
            top-left = radius;
            top-right = radius;
            bottom-left = radius;
            bottom-right = radius;
          };
          clip-to-geometry = true;
        }
        {
          matches = [ { app-id = ''^org\.wezfurlong\.wezterm$''; } ];
          default-column-width = {};
        }
      ];

      screenshot-path =
        "${config.xdg.userDirs.pictures}/screencap-%d-%m-%Y_%H-%M-%S";
      hotkey-overlay.skip-at-startup = true;

      binds = {
        "Mod+Shift+E".action.quit.skip-confirmation = true;
        "Mod+D".action.spawn = [
          "bemenu-run"
          "-H" "44"
          "-p" " "
          "-i"
          "--fn" "CaskaydiaCove Nerd Font Mono Semi-Bold 10"
          "--tb" "#00000000"
          "--fb" "#00000000"
          "--nb" "#00000000"
          "--hb" "#00000000"
          "--ab" "#00000000"
          "--ff" "#FFFFFFFF"
          "--cf" "#00000000"
          "--nf" "#FFFFFFFF"
          "--hf" "#FFAAEEFF"
        ];
      };

      input = {
        focus-follows-mouse = true;
        warp-mouse-to-focus = true;
      };

      cursor.theme = "catppuccin-mocha-pink-cursors";
    };
  };
}
