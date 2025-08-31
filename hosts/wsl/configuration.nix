{
  lib,
  machine,
  ...
}:

{
  imports = [
    <nixos-wsl/modules>
    ../../users/nixos
  ]
  ++ (with (lib.findModules ../../profiles/system); [
    base
  ]);

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  time.timeZone = lib.mkForce "Europe/Zurich";
  systemd.network.wait-online.extraArgs = map (
    interface: "--interface=${interface}"
  ) machine.interfaces;
}
