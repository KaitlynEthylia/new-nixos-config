{ pkgs, lib, config, ... }:

{
  options.ethy.doas = lib.mkEnableOption "enables `doas`";

  config = lib.mkIf config.ethy.doas {
    security.sudo.enable = false;
    environment.systemPackages = [ (pkgs.writeShellScriptBin ''sudo'' ''exec doas $@'') ];

    security.doas.enable = true;
    security.doas.extraRules = [
      {
        groups = [ "wheel" ];
        persist = true;
        keepEnv = true;
      }
      {
        cmd = "/run/current-system/sw/bin/*";
        noPass = true;
        keepEnv = true;
      }
      {
        cmd = "/nix/store/*/bin/switch-to-configuration";
        noPass = true;
        keepEnv = true;
      }
    ];
  };
}
