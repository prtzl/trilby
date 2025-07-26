{ trilby, lib, pkgs, ... }:

{
  imports = with (lib.findModules ../../profiles/home); [ base base-machine ];

  home.packages = with pkgs.unstable;
    [ ] ++ lib.optionals (trilby.edition == "workstation") [
      # browser
      ungoogled-chromium

      # Dev
      arduino
      drawio

      # Content creation
      audacity
      gimp

      # Utility
      enpass
      pavucontrol
      transmission_4-gtk

      # file explorer
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.tumbler
      mpv

      # Communication
      signal-desktop
    ];

  programs.git = {
    userName = "prtzl";
    userEmail = "matej.blagsic@protonmail.com";
    extraConfig = { core = { init.defaultBranch = "master"; }; };
  };
}
