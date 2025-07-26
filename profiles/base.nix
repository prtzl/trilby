{trilby, inputs, local, lib, pkgs, ...}:

{
  nix.registry.stable.flake = local.nixpkgs;
  nix.registry.unstable.flake = inputs.nixpkgs-unstable;
  environment.systemPackages = with pkgs; [

  ] ++ lib.optionals (trilby.edition == "workstation") [
      fd
      eza
      ripgrep
      parted
      fd
      ffmpeg-full
      hwinfo
      jq
      fx
      xh
      bat
      btop
    ]  ;
}
