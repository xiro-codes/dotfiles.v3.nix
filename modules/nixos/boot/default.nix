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
    };
  };
  config = {
    boot.loader.timeout = lib.mkDefault self.timeout;
  };
}
