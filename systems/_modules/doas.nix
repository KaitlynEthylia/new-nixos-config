{ pkgs, ... }:

{
  security.sudo.enable = false;
  environment.systemPackages = [ (pkgs.writeShellScriptBin ''sudo'' ''exec doas $@'') ];

  security.doas.enable = true;
  security.doas.extraRules = [
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
}
