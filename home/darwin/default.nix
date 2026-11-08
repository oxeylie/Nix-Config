{
  lib,
  global-config,
  pkgs,
  ...
}:
{
  imports = [
    ../common/default.nix
    ./home.nix
    ./ghostty.nix
    ./zsh.nix
    ./sketchybar.nix
    ./files.nix
    ./rift.nix
    ./atuin.nix
  ];

  home-config.status-bar = lib.mkDefault false;
  home-config.fastfetch.logo = import ./fastfetch-logo.nix { inherit pkgs; };
  home-config.fastfetch.osString = "/\\/\\acOS ";

  # Higher priority than makedefault but lower than standard definition
  home-config.external-drive.enable = lib.mkOverride 500 global-config.darwin-system.external-drive.enable;
  home-config.external-drive.path = lib.mkOverride 500 global-config.darwin-system.external-drive.path;
}
