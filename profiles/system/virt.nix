{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    libguestfs
    spice-gtk
    spice-vdagent
    virt-manager
    virt-viewer
    # docker-compose
    # podman-compose
  ];
}
