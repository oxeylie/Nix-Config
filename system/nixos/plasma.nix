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

    services.accounts-daemon.enable = true;
    systemd.tmpfiles.rules = [
      "d /var/lib/AccountsService/icons 0755 root root -"
      "d /var/lib/AccountsService/users 0755 root root -"
      "L+ /var/lib/AccountsService/icons/${config.users.users.camille.name} - - - - ${./../../resources/oxeylie.jpg}"
      "L+ /var/lib/AccountsService/users/${config.users.users.camille.name} - - - - ${pkgs.writeText config.users.users.camille.name ''
        [User]
        Icon=/var/lib/AccountsService/icons/${config.users.users.camille.name}
        SystemAccount=false
      ''}"
    ];

    stylix.targets = {
      qt.enable = false;
    };
  };
}
