{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
in {
  imports = [];
  home = {
    username = "tod";
    homeDirectory = "/home/tod";
    stateVersion = "24.05";
  };
  custom.impermanence.enable = true;
  custom.shell.enable = true;
  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    git = {
      enable = true;
      userName = "xiro-codes";
      userEmail = "github@tdavis.dev";
      extraConfig = {
        credential.helper = "store";
        safe.directory = "*";
        core.sshCommand = "ssh -i /home/tod/.ssh/github";
      };
    };
  };
}
