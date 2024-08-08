{ allExcept, ... }:

{
  imports = allExcept [] ./.;

  hardware.xpadneo.enable = true;
}
