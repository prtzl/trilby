{
  nixConfig = {
    extra-substituters = [ "https://cache.ners.ch/trilby" ];
    extra-trusted-public-keys = [ "trilby:AKUGezHi4YbPHCaCf2+XnwWibugjHOwGjH78WqRUnzU=" ];
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    trilby = {
      # url = "/home/matej/projects/trilby"; # local work copy for testing
      url = "github:prtzl/trilby-origin/defaults"; # current branch
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager";
      };
    };
    nvimnix.url = "github:prtzl/nvimnix";
    jlink-pack.url = "github:prtzl/jlink-nix";
  };
  outputs =
    inputs:
    with builtins;
    let
      inherit (inputs.trilby) lib;
      allConfigurations =
        with lib;
        pipe ./hosts [
          findModules
          (mapAttrs (hostname: host: import host { inherit inputs lib; }))
        ];
    in
    {
      inherit (inputs.trilby) legacyPackages;
      nixosConfigurations = allConfigurations;
      darwinConfigurations = allConfigurations;
    };
}
