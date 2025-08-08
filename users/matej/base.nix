{
  lib,
  pkgs,
  trilby,
  ...
}:

{
  imports = with (lib.findModules ../../profiles/home); [
    base
  ];

  home.packages =
    with pkgs.unstable;
    [ ]
    ++ lib.optionals (trilby.edition == "workstation") [
      # browser
      ungoogled-chromium

      # Dev
      arduino
      drawio

      # Content creation
      audacity
      gimp
      obs-studio

      # Utility
      enpass
      pavucontrol
      transmission_4-gtk

      # file explorer
      xfce.thunar
      xfce.thunar-archive-plugin
      xfce.tumbler
      mpv # goes to black when entering and exiting fullscreen for a few seconds
      vlc

      # Communication
      signal-desktop
    ];

  programs.git = {
    userName = "prtzl";
    userEmail = "matej.blagsic@protonmail.com";
    extraConfig = {
      core = {
        init.defaultBranch = "master";
      };
    };
  };
}
