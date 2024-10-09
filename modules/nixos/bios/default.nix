{
  config,
  lib,
  ...
}: let
  cfg = config.custom;
  self = cfg.boot.bios;
  inherit (lib) mkOption mkIf types mkDefault;
in {
  options.custom.boot.bios = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = lib.mdDoc ''
      	Configure boot loader
      '';
    };
  };
  config = mkIf (self.enable) {
    boot.loader = {
      systemd-boot.enable = false;
      grub.useOSProber = true;
    };
    assertions = [
      {
        assertion = !(cfg.boot.efi.bootloader == "");
        message = "BIO's || UEFI";
      }
    ];
  };
}
