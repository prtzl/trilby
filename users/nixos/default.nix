{
  lib,
  trilby,
  machine,
  ...
}:

lib.trilbyUser trilby {
  imports = lib.findModulesList ./.;
  uid = 1000;
  name = "nixos";
  extraGroups = [
    "wheel"
    "networkmanager"
    "dialout"
    "podman"
    "docker"
    "adbusers"
  ];
  extraSpecialArgs = { inherit machine; };
}
