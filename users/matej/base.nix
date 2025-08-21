{
  lib,
  pkgs,
  trilby,
  ...
}:

{
  imports = with (lib.findModules ../../profiles/home); [
    base
  ];

  home.packages =
    with pkgs;
    [ ]
    ++ lib.optionals (trilby.edition == "workstation") [
      # Dev
      arduino
      drawio

      # Content creation
      audacity
      gimp
      obs-studio
    ];

  programs.git = {
    userName = "prtzl";
    userEmail = "matej.blagsic@protonmail.com";
    extraConfig = {
      core = {
        init.defaultBranch = "master";
      };
    };
  };
}
