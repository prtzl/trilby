{ local, lib, pkgs, ... }:

{
  imports = [ 
    local.nixos-hardware.nixosModules.common-cpu-amd
    local.nixos-hardware.nixosModules.common-gpu-intel
    local.nixos-hardware.nixosModules.common-pc
    local.nixos-hardware.nixosModules.common-pc-ssd
    local.nvimnix.nixosModules.nixos
    ../../users/matej
    ../../profiles/base.nix
    ../../profiles/udev.nix
    ../../profiles/virt.nix
  ];
  programs.nvimnix.enable= true;
  networking.hostName = "poli";
  services.xserver.xkb.layout = "us";
  i18n.defaultLocale = "en_GB.UTF-8";
  time.timeZone = lib.mkForce "Europe/Zurich";
  systemd.network.wait-online.extraArgs = [ "--interface=enp13s0" ];
  nix.settings = {
    # max-jobs = maximum packages built at once
    max-jobs = 16;
    # cores = maximum threads used by a job/package
    cores = 2;
  };

  fonts = lib.mkForce {
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
        monospace = [ "FiraCode Nerd Font" ];
      };
    };
    fontDir.enable = true;
    packages = with pkgs; [
      nerd-fonts.fira-code
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
    ];
  };
}
