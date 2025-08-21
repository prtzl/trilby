{
  lib,
  pkgs,
  trilby,
  ...
}:

{
  imports =
    with (lib.findModules ./.);
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
    ++ (trilby.edition == "workstation") [
      # Web
      ungoogled-chromium
      transmission_4-gtk

      # Utility
      enpass

      # Communication
      signal-desktop
    ];
}
