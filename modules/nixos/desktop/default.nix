{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.custom;
  self = cfg.desktop;
  inherit (lib) mkOption mkIf getExe;
  inherit (lib.types) bool;
  command = ''
  	${getExe pkgs.greetd.tuigreet}
  '';
in {
  options.custom.desktop = {
    enable = mkOption {
      type = bool;
      default = false;
      description = ''
      	Enable desktop enviroment.
	#TODO
	- configure other enviroments
	- impermenice issues
      '';
    };
  };

  config = mkIf self.enable {
    xdg.portal.enable = true;

    environment.systemPackages = with pkgs; [
      xdg-user-dirs
      xdg-utils
    ];

    boot.plymouth.enable = true;

    environment.variables = {
      NIXOS_OZONE_WL = "1";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland";
      GDK_DPI_SCALE = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "qt5ct";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on";
    };

    users.users.greeter = {
    	name = "greeter";
	isSystemUser = true;
	group = "greeter";
    };
    users.groups.greeter = {};
    security.pam.services.swaylock = {};
    programs.hyprland.enable = true;

    services = {
      flatpak.enable = true;
      pipewire.enable = true;
      greetd = {
      	enable = true;
	vt = 2;
	settings.default_session = {
		inherit command;
		user = "greeter";
	};
      };
    };
  };
}
