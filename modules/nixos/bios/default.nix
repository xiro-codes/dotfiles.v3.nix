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
      description = ''
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
