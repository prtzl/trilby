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
      name = "poli";
      hostname = name;
      interfaces = [ "enp13s0" ];
      temp_probes = [
        {
          path = "/dev/cpu_temp";
          icon = "";
          color = "#3ffc81";
        }
        {
          path = "/dev/gpu_temp";
          icon = "🏭";
          color = "#982daf";
        }
        {
          path = "/dev/water_temp";
          icon = "🌊";
          color = "#3385e6";
        }
        {
          path = "/dev/motherboard_temp";
          icon = "🎂";
          color = "#982daf";
        }
      ];
      disks = [
        "/"
        "/storage"
      ];
    };
  };
}
