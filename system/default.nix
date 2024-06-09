{ allExcept, pkgs, ... }:

{
  imports = allExcept [] ./.;

  networking.hostName = "nix";
  networking.networkmanager.enable = true;

  security.doas.enable = true;
  security.doas.extraRules = [ {
    groups = [ "wheel" ];
    persist = true;
    keepEnv = true;
  } ];
  security.sudo.enable = false;
  environment.systemPackages = with pkgs; [
    git
    dconf
    (writeShellScriptBin "sudo" ''exec doas $@'')
  ];

  programs.zsh.enable = true;

  users.users.kaitlyn = {
    isNormalUser = true;
    description = "kaitlyn";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  services.udisks2.enable = true;

  system.stateVersion = "23.05";
}
