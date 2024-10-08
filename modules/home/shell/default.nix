{
	pkgs,
	config,
	lib,
	...
}: let 
	cfg = config.custom;
	inherit (lib) mkOption mkIf types;
in {
	options.custom.shell.enable = mkOption {
		type = types.bool;
		default = false;
	};
	config = mkIf cfg.shell.enable {
		programs = {
			eza.enable = true;
			zoxide.enable = true;
			fish = {
				enable = true;
				shellAbbrs = {
					ls = "eza --icons always";
					cd = "z";
				};
				interactiveShellInit = "zoxide init fish | source";
			};
		};
	};
}
