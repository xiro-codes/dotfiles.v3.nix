{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.custom;
  inherit (lib) mkOption types mkIf;
in {
  options.custom.impermanence.enable = mkOption {
    type = types.bool;
    default = false;
  };
  config = mkIf cfg.impermanence.enable {
    # todo: smells bad
    home.persistence."/persist/home/tod" = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        ".ssh"
        ".config/cosmic"
        ".local/share/cosmic"
        ".local/state/cosmic"
        ".local/state/cosmic-comp"
        ".local/share/direnv"
	".local/share/flatpak"
	".mozilla"
      ];
      files = [
      	".local/share/fish/fish_history"
      ];
      allowOther = true;
    };
  };
}
