{
  local,
  lib,
  trilby,
  ...
}:

{
  imports = [
    ../../users/matej
    local.nixos-hardware.nixosModules.common-cpu-amd
    local.nixos-hardware.nixosModules.common-gpu-intel
    local.nixos-hardware.nixosModules.common-pc
    local.nixos-hardware.nixosModules.common-pc-ssd
    local.nvimnix.nixosModules.nvimnix
  ] ++ (with (lib.findModules ../../profiles/system); [ base ]);

  networking.hostName = "poli";
  services.xserver.xkb.layout = "us";
  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = lib.mkForce "Europe/Zurich";
  systemd.network.wait-online.extraArgs = [ "--interface=enp13s0" ];

  boot = {
    # nct6775: asrock board sensors
    kernelModules = [
      "nct6775"
    ];
    binfmt.emulatedSystems = [
      "aarch64-linux"
      "x86_64-windows"
    ];
  };

  # This should be done with home module, but I cant import this
  programs.nvimnix.enable = true;

  # ok, so how do I do this only for steam ... ?
  nixpkgs.config.allowUnfree = true;

  programs.steam = lib.optionals (trilby.edition == "workstation") {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}
