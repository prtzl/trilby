{
  lib,
  local,
  machine,
  ...
}:

{
  imports = [
    ../../users/matej
    local.nixos-hardware.nixosModules.common-cpu-amd
    local.nixos-hardware.nixosModules.common-gpu-intel
    local.nixos-hardware.nixosModules.common-pc
    local.nixos-hardware.nixosModules.common-pc-ssd
  ]
  ++ (with (lib.findModules ../../profiles/system); [
    base
    steam
  ]);

  time.timeZone = lib.mkForce "Europe/Zurich";
  systemd.network.wait-online.extraArgs = map (
    interface: "--interface=${interface}"
  ) machine.interfaces;

  boot.kernelModules = [
    # nct6775: asrock board sensors
    "nct6775"
  ];
}
