{
  lib,
  ...
}:

lib.trilbySystem {
  trilby = {
    edition = "workstation";
    buildPlatform = "x86_64-linux";
    hostPlatform = "x86_64-linux";
  };
  modules = lib.findModulesList ./.;
}
