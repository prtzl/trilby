{
  lib,
  machine,
  trilby,
  pkgs,
  ...
}:

lib.trilbyUser trilby {
  imports = [
    (
      with pkgs;
      import ./base.nix {
        inherit
          pkgs
          lib
          machine
          trilby
          ;
      }
    )
  ];
  uid = 1000;
  name = "matej";
  initialHashedPassword = "$y$j9T$CF142XO22THqvvp88lMR5/$.EveMJEz6yR6Za/3rvgFNFJ1f15a2xBwEVnUqca.5tA";
  extraGroups = lib.mkForce [
    "wheel"
    "libvirtd"
    "networkmanager"
    "dialout"
    "audio"
    "video"
    "usb"
    "podman"
    "docker"
    "openrazer"
    "kvm"
    "adbusers"
  ];
}
