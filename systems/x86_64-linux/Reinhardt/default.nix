{
  pkgs,
  host,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    (import ./boot-configuration.nix {})
    (import ./ssd-configuration.nix {})
    (import ./hdd-configuration.nix {})
  ];
  # only define crital packages ie system tools
  environment.systemPackages = with pkgs; [
    nvtopPackages.amd
    firefox
  ];

  custom.boot = {
    timeout = 5;
    efi.bootloader = "systemd-boot";
  };

  custom = {
    settings.enable = true;
    desktop.enable = true;
    impermanence.enable = true;
    # define host specific packages
    #applications = [ ];
  };
  programs.steam.enable = true;

  users.users.tod = {
    name = "tod";
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "networkmanager" "input" "uinput"];
    shell = pkgs.fish;
    password = host;
  };
  programs.fish.enable = true;
  fileSystems."/home/tod/.steam" = {
  	device = "/persist/steam";
	fsType = "none";
	options =  ["bind"];
	noCheck = true;
  };
}
