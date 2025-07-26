{ local, lib, trilby, ... }:

{
  imports = [
    local.nixos-hardware.nixosModules.common-cpu-amd
    local.nixos-hardware.nixosModules.common-gpu-intel
    local.nixos-hardware.nixosModules.common-pc
    local.nixos-hardware.nixosModules.common-pc-ssd
    local.nvimnix.nixosModules.nvimnix
    ../../users/matej
  ] ++ (with (lib.findModules ../../profiles/system); [ base ]);

  networking.hostName = "poli";
  services.xserver.xkb.layout = "us";
  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = lib.mkForce "Europe/Zurich";
  systemd.network.wait-online.extraArgs = [ "--interface=enp13s0" ];

  nix = {
    settings = {
      # max-jobs = maximum packages built at once
      max-jobs = 16;
      # cores = maximum threads used by a job/package
      cores = 2;
    };
  };

  # nct6775: asrock board sensors
  boot.kernelModules = [ "nct6775" ];

  # This should be done with home module, but I cant import this
  programs.nvimnix.enable = true;

  # ok, so how do I do this only for steam ... ?
  nixpkgs.config.allowUnfree = true;

  programs.steam = lib.optionals (trilby.edition == "workstation") {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall =
      true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}
