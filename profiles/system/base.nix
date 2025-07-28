{ trilby, inputs, local, lib, pkgs, ... }:

{
  imports = with (lib.findModules ./.); [ udev virt fonts ];

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
    gc = {
      automatic = true;
      dates = lib.mkForce "weekly";
      options = lib.mkForce "--delete-older-than 7d";
    };
    settings = {
      trusted-users = [ "root" "@wheel" ];
      auto-optimise-store = true;
    };
    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations
      binary-caches-parallel-connections = 50
      preallocate-contents = false
    '';
  };

  environment.systemPackages = with pkgs;
    [

    ] ++ lib.optionals (trilby.edition == "workstation") [
      bat
      btop
      eza
      fastfetch
      fd
      fd
      ffmpeg-full
      fx
      gthumb
      hwinfo
      jq
      monitorets
      parted
      ripgrep
      xh
    ];

  xdg.mime.inverted.defaultApplications."gthumb.desktop" = lib.mkForce [
    "image/bmp"
    "image/gif"
    "image/jpeg"
    "image/jpg"
    "image/pjpeg"
    "image/png"
    "image/svg+xml"
    "image/svg+xml-compressed"
    "image/tiff"
    "image/vnd.wap.wbmp"
    "image/x-bmp"
    "image/x-gray"
    "image/x-icb"
    "image/x-icns"
    "image/x-ico"
    "image/x-pcx"
    "image/x-png"
    "image/x-portable-anymap"
    "image/x-portable-bitmap"
    "image/x-portable-graymap"
    "image/x-portable-pixmap"
    "image/x-xbitmap"
    "image/x-xpixmap"
  ];
}
