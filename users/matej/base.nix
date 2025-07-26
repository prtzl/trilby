{ trilby, lib, pkgs, ...}:

{
  imports = with (lib.findModules ../../profiles);
    [
      nvim
      ranger
      shell
      tio
      tmux
      zsh
    ] ++ lib.optionals (trilby.edition == "workstation") (with (lib.findModules ../../profiles); [
      alacritty
      dunst
      hyprland
      themes
      (import waybar "poli")
    ]);
  home.packages = with pkgs.unstable; [
  ] ++ lib.optionals (trilby.edition == "workstation") [
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
}
