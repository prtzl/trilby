{
  lib,
  pkgs,
  ...
}:

{
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    xwayland.enable = true;
  };

  # Disable Trilby defaults
  services.xserver.displayManager.gdm.enable = lib.mkForce false;
  services.xserver.displayManager.gdm.wayland = lib.mkForce false;

  # Light weight and nice
  services.displayManager.ly = {
    enable = true;
    settings = {
      save = true; # save current session as default - handy
      load = true; # save current login username
    };
  };

  # needed by xfce apps to save config - yikes, well, at least not gnome
  programs.xfconf.enable = true;

  # Fixes electron apps in wayland, so I've read.
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
