{
  inputs,
  lib,
  machine,
  pkgs,
  trilby,
  ...
}:

{
  imports =
    with (lib.findModules ./base/.);
    [
      fonts
      nvim
      pipewire
      udev
    ]
    ++ lib.optionals (trilby.edition == "workstation") [
      hyprland
      virt
      wine
    ];

  nix = {
    monitored.notify = false;
    registry = {
      stable.flake = inputs.nixpkgs;
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
      trusted-users = [
        "root"
        "@wheel"
      ];
      auto-optimise-store = true;
    };
    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations
      binary-caches-parallel-connections = 50
      preallocate-contents = false
    '';
  };

  networking.hostName = machine.hostname;
  services.xserver.xkb.layout = "us";
  i18n.defaultLocale = "en_GB.UTF-8";

  programs.firefox = {
    enable = (trilby.edition == "workstation");
    package = lib.mkForce pkgs.firefox;
  };

  environment.systemPackages =
    with pkgs;
    [
      bat # replacement for cat
      btop # system info graphs, usage, etc. Modern top
      eza # replacement for exa, replacement for ls
      fastfetch # replacement for neofetch :'(
      fd # modern find
      ffmpeg-full # yes
      fx # json  viewer
      hwinfo # self explanatory
      jq # json processor
      parted # partitions
      pciutils # info on pci devices
      ripgrep # modern grep
      smartmontools # disk checks
      usbutils # info on usb devices
      xh
    ]
    ++ lib.optionals (trilby.edition == "workstation") [
      gthumb # image viewer of choice
      monitorets # GUI for temperature sensors
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
