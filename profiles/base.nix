{ trilby, inputs, local, lib, pkgs, ... }:

{
  imports = [ ./udev.nix ./virt.nix ./fonts.nix ];

  nix = {
    monitored.notify = false;
    registry = {
      stable.flake = local.nixpkgs;
      unstable.flake = inputs.nixpkgs-unstable;
      master.to = {
        owner = "nixos";
        repo = "nixpkgs";
        type = "github";
      };
    };
  };

  environment.systemPackages = with pkgs;
    [

    ] ++ lib.optionals (trilby.edition == "workstation") [
      bat
      btop
      eza
      fd
      fd
      ffmpeg-full
      fx
      hwinfo
      jq
      parted
      ripgrep
      xh
    ];
}
