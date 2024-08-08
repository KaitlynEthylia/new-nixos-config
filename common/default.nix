{ allExcept, ... }:

{
  imports = allExcept [] ./.;

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    use-xdg-base-directories = true;
  };

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "pink";
  };
}
