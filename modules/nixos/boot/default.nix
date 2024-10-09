{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.custom;
  self = cfg.boot;

  inherit (lib) mkOption mkIf mkMerge types mkDefault;
in {
  options.custom.boot = {
    timeout = mkOption {
      type = types.int;
      default = 5;
      description = lib.mdDoc ''
      	Set default timeout for grub or systemd.
      '';
    };
  };
  config = {
    boot.loader.timeout = lib.mkDefault self.timeout;
  };
}
