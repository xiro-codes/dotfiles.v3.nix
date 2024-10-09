{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.custom;
  inherit (lib) mkOption mkIf types;
in {
  options.custom.settings = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = lib.mdDoc ''
      	configure common settings
      '';
    };
  };
  config = mkIf cfg.settings.enable {
    i18n.defaultLocale = "en_US.UTF-8";
    time.timeZone = "America/Chicago";
    time.hardwareClockInLocalTime = true;

    system.autoUpgrade = {
      enable = true;
      flake = "path:/etc/nixos";
      dates = "weekly";
    };

    nix = {
      package = pkgs.nixVersions.latest;
      settings = {
        substituters = ["https://cosmic.cachix.org/"];
        trusted-public-keys = ["cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="];
      };
      extraOptions = ''
        extra-experimental-features = nix-command
        extra-experimental-features = flakes
        extra-experimental-features = auto-allocate-uids
        keep-outputs = true
        keep-derivations = true
      '';

      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      optimise = {
        automatic = true;
        dates = ["weekly"];
      };
    };
  };
}
