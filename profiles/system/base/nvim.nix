{
  local,
  ...
}:

{
  imports = [
    local.nvimnix.nixosModules.nvimnix
  ];
  programs.nvimnix.enable = true;
}
