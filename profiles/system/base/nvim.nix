{
  local,
  ...
}:

{
  # using ${system} causes infinite recursion ... wot?
  imports = [
    local.nvimnix.nixosModules."x86_64-linux".nvimnix
  ];
  programs.nvimnix.enable = true;
}
