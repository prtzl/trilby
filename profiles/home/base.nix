{
  lib,
  machine,
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
      (import waybar machine)
      alacritty
      dunst
      hyprland
      themes
      tio
    ];
}
