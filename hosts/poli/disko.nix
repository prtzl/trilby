{
  disko.devices.disk = {
    "/dev/disk/by-id/nvme-WD_BLACK_SN8100_2000GB_25221P801548" = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-WD_BLACK_SN8100_2000GB_25221P801548";
      content = {
        type = "gpt";
        partitions = {
          boot = { label = "boot"; size = "1M"; type = "EF02"; priority = 0; };
          EFI = {
            label = "EFI";
            size = "1G";
            type = "EF00";
            priority = 1;
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          Trilby = {
            label = "Trilby";
            size = "100%";
            content = {
              type = "filesystem";
              format = "xfs";
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}