{
  pkgs,
  config,
  lib,
  ...
}:
let
  plasma-enable = config.nixos-system.plasma6.enable;
in
{
  options = {
    nixos-system.plasma6.enable = lib.mkEnableOption "Whether to enable the Nixos Plasma config";
  };

  config = lib.mkIf plasma-enable {
    # Enable the X11 windowing system (login primarly)
    services.xserver = {
      enable = true;
      xkb = {
        layout = "fr";
        variant = "";
      };
    };
    # Enable plasma desktop manager
    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm = {
      enable = true;
      theme = "breeze";
      wayland.enable = true;
    };

    environment.systemPackages = [
      (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
        [General]
        background=${config.common.theme.wallpaper}
      '')
    ];

    stylix.targets = {
      qt.enable = false;
    };
  };
}
