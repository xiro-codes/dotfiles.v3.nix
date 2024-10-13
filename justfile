install DEVICE HOST=`hostname`:
	nix run github:nix-community/disko -- --mode disko systems/x86_64-linux/{{HOST}}/disk-configuration.nix --arg device '"{{DEVICE}}"'
	nixos-install --flake .#{{HOST}}

# Build iso with nixos-generators
make-iso HOST=`hostname`:
	nix build .#nixosConfigurations.{{HOST}}.config.formats.install-iso
	#mv result {{HOST}}.iso
boot HOST=`hostname`:
	sudo nixos-rebuild boot --flake ./#{{HOST}}
rebuild:
	sudo nixos-rebuild switch

update-rebuild:
	nix flake update 
	sudo nixos-rebuild switch --upgrade

check:
	nix flake check

build-docs:
	nix build .#docs

start-vm HOST=`hostname`:  
	nixos-rebuild build-vm --flake ./#{{HOST}}
