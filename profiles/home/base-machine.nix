{ trilby, lib, ... }:

{
  imports = lib.optionals (trilby.edition == "workstation") (
    with (lib.findModules ../../profiles/home);
    [
      (import waybar "poli")
      alacritty
      dunst
      hyprland
      themes
      tio
    ]
  );
}
