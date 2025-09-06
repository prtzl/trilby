{
  config,
  lib,
  local,
  machine,
  ...
}:

{
  imports = [
    ../../users/matej
    local.nixos-hardware.nixosModules.common-cpu-intel
    local.nixos-hardware.nixosModules.common-gpu-intel
    local.nixos-hardware.nixosModules.common-pc
    local.nixos-hardware.nixosModules.common-pc-ssd
  ]
  ++ (with (lib.findModules ../../profiles/system); [
    base
  ]);

  systemd.network.wait-online.extraArgs = map (
    interface: "--interface=${interface}"
  ) machine.interfaces;

  services = {
    acpid.enable = true;
    blueman.enable = true;
    hardware.bolt.enable = true;
    throttled.extraConfig = "";
    tlp.settings = {
      # Do not suspend USB devices
      USB_AUTOSUSPEND = 0;
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 50;
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_AC = 1;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;
    };
    udev = {
      extraRules = ''
        # Give CPU temp a stable device path
        # Intel i7 8550U
        ACTION=="add", SUBSYSTEM=="hwmon", ATTRS{name}=="coretemp", RUN+="/bin/sh -c 'ln -s /sys$devpath/temp1_input /dev/cpu_temp'"
      '';
    };
  };

  # powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware = {
    # Following line fixed missing drivers for the wireless card when upgrading from 24.11 to 25.05.
    # enableAllFirmware = true;
    bluetooth.enable = true;
    acpilight.enable = true;
  };
}
