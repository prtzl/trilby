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
      name = "karla";
      hostname = name;
      interfaces = [
        "enp0s31f6"
        "wlp61s0"
      ];
      temp_probes = [
        {
          path = "/dev/cpu_temp";
          icon = "";
          color = "#3ffc81";
        }
      ];
      disks = [
        "/"
      ];
    };
  };
}
