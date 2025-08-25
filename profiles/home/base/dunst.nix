{
  config,
  pkgs,
  ...
}:

let
  volume = pkgs.writeShellApplication {
    name = "volume";
    runtimeInputs = [ config.services.dunst.package ];
    text = builtins.readFile ./dotfiles/dunst/volume.sh;
  };
in
{
  home.packages = with pkgs; [
    volume
    libnotify
  ];
  services.dunst = {
    enable = true;
    # This is broken. Works on rebuild, but the file is cleaned-up after garbage collect
    # And after service restart the file is gone and dunst breaks - goes default
    # configFile = ./dotfiles/dunst/dunstrc;
    settings = {
      global = {
        origin = "top-center";
        alignment = "center";
        notification_limit = 3;
        offset = "(0, 10)";
        separator_height = 1;
        font = "Monospace 18";
        width = "(0, 800)";
        height = "(0, 300)";
        progress_bar_height = 30;
        format = "<b>%s - %a</b>\\n%b";
        vertical_alignment = "center";
        stack_duplicates = true;
        show_indicators = false;
      };

      urgency_low = {
        timeout = 5;
      };

      urgency_normal = {
        timeout = 5;
      };

      urgency_critical = {
        timeout = 5;
      };
    };
  };
}
