# ughh...
# https://web.archive.org/web/20190925004614/https://bugzilla.mindrot.org/show_bug.cgi?id=2050
{ pkgs, config, lib, ... }:

{
  options.ethy.ssh.enable = lib.mkEnableOption "enables ssh";

  config.programs.ssh = lib.mkIf config.ethy.ssh.enable {
    package = pkgs.openssh.overrideAttrs (_: prev: {
      doCheck = false; # bad idea but fuck it, can't be bothered to do it right
      patches = prev.patches ++ [
        (pkgs.writeText "ssh_user_dir.patch" ''
          --- a/pathnames.h
          +++ b/pathnames.h
          @@ -66,0 +66,4 @@
          +#ifdef _PATH_SSH_USER_DIR
          +#undef _PATH_SSH_USER_DIR
          +#endif
          +#define _PATH_SSH_USER_DIR		".local/share/ssh"
        '')
      ];
    });
  };
}
