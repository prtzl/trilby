{
  lib,
  trilby,
  ...
}:

{
  imports =
    with (lib.findModules ./.);
    [
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
}
