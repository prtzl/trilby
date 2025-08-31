{
  inputs,
  lib,
  ...
}:

lib.trilbySystem {
  trilby = {
    edition = "workstation";
    buildPlatform = "x86_64-linux";
    hostPlatform = "x86_64-linux";
  };
  modules = (lib.findModulesList ./.) ++ [ ];
  specialArgs = {
    local = inputs; # we don't know how to pass this flake inputs as just inputs. Currently it's trilby's
    # Reused machine information. Most of this is for waybar he he
    machine = rec {
      name = "wsl";
      hostname = name;
      interfaces = [ "eth0" ];
      disks = [
        "/"
      ];
    };
  };
}
