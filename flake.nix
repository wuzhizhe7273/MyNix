{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };
  outputs =
    inputs@{ self, nixpkgs, ... }:
    {
      nixosConfigurations =
        let
          hosts = {
            nixos-wsl = {
              paltform = "x86_64-linux";
              stateVersion = "24.11";
              modules = [ ./hosts/wsl ];
            };
          };
          mkHost =
            host:
            {
              paltform,
              stateVersion,
              modules,
            }:
            nixpkgs.lib.nixosSystem {
              system = paltform;
              specialArgs = { inherit inputs; };
              modules = [
                {
                  networking.hostName = host;
                  system.stateVersion = stateVersion;
                }
                ./base.nix
                ./home
              ] ++ modules;
            };
          configurations = builtins.mapAttrs mkHost hosts;
        in
        configurations;
    };
}
