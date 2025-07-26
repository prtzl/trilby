{ trilby, lib, pkgs, ... }:

{
  imports = with (lib.findModules ../../profiles/home);
    [ base ] ++ lib.optionals (trilby.edition == "workstation")
    (with (lib.findModules ../../profiles/home); [
      (import waybar "poli")
      alacritty
      dunst
      hyprland
      themes
      tio
    ]);

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
