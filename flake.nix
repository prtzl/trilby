{
  nixConfig = {
    extra-substituters = [ "https://cache.ners.ch/trilby" ];
    extra-trusted-public-keys =
      [ "trilby:AKUGezHi4YbPHCaCf2+XnwWibugjHOwGjH78WqRUnzU=" ];
  };
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable = { url = "github:nixos/nixpkgs/nixos-unstable"; };
    nixos-hardware = { url = "github:nixos/nixos-hardware"; };
    home-manager = { url = "github:nix-community/home-manager"; };
    trilby = {
      url = "github:ners/trilby";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-unstable.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    nvimnix = { url = "github:prtzl/nvimnix"; };
  };
  outputs = inputs:
    with builtins;
    let
      inherit (inputs.trilby) lib;
      allConfigurations = with lib;
        pipe ./hosts [
          findModules
          (mapAttrs (hostname: host: import host { inherit inputs lib; }))
        ];
    in {
      inherit (inputs.trilby) legacyPackages;
      nixosConfigurations = allConfigurations;
      darwinConfigurations = allConfigurations;
    };
}
