{
  lib,
  trilby,
  machine,
  ...
}:

lib.trilbyUser trilby {
  imports = lib.findModulesList ./.;
  uid = 1000;
  name = "matej";
  initialHashedPassword = "$y$j9T$CF142XO22THqvvp88lMR5/$.EveMJEz6yR6Za/3rvgFNFJ1f15a2xBwEVnUqca.5tA";
  extraGroups = lib.mkForce [
    "adbusers"
    "audio"
    "dialout"
    "docker"
    "kvm"
    "libvirtd"
    "networkmanager"
    "openrazer"
    "plugdev"
    "podman"
    "usb"
    "video"
    "wheel"
  ];
  extraSpecialArgs = { inherit machine; };
}
