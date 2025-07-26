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
