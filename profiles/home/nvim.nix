{ lib, ... }:

{
  programs.nixvim.enable = lib.mkForce false;
}
