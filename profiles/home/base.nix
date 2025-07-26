{ lib, ... }:

{
  imports = with (lib.findModules ./.); [ nvim ranger tmux zsh ];
}
