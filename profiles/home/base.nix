{
  lib,
  pkgs,
  trilby,
  ...
}:

{
  imports =
    with (lib.findModules ./base);
    [
      btop
      nvim
      ranger
      tmux
      zsh
    ]
    ++ lib.optionals (trilby.edition == "workstation") [
      alacritty
      dunst
      hyprland
      themes
      tio
      waybar
    ];

  home.packages =
    with pkgs;
    [ ]
    ++ lib.optionals (trilby.edition == "workstation") [
      # Web
      ungoogled-chromium
      transmission_4-gtk

      # Utility
      unstable.enpass # unstable is unfree

      # Communication
      signal-desktop
    ];
}
