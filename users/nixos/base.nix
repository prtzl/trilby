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
    ];

  programs.git = {
    extraConfig = {
      core = {
        init.defaultBranch = "main";
      };
    };
  };
}
