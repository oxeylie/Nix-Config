{
  pkgs,
  config,
  lib,
  themeUtils,
  ...
}:
{
  config = {

    ## Networking
    networking.networkmanager.enable = true;
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Open ports in the firewall.
    networking.firewall.allowedTCPPorts = [ 22 ];
    networking.firewall.allowedUDPPorts = [ 22 ];

    # Enable the OpenSSH daemon.
    services.openssh.enable = true;
    services.openssh.allowSFTP = true;

    ## General system config
    # No sudo shutdown when on device
    security.rtkit.enable = true;

    # Internationalisation properties.
    time.timeZone = "Europe/Paris";
    i18n = {
      defaultLocale = "en_US.UTF-8";

      extraLocales = [
        "en_US.UTF-8/UTF-8"
        "fr_FR.UTF-8/UTF-8"
      ];

      extraLocaleSettings = {
        # Time & Date
        LC_TIME = "en_DK.UTF-8"; # English text + 24h + YYYY-MM-DD format
        # Numbers, currency, measurement
        LC_NUMERIC = "fr_FR.UTF-8"; # 1 234 567,89
        LC_MONETARY = "fr_FR.UTF-8"; # € style currency
        LC_MEASUREMENT = "fr_FR.UTF-8"; # Metric units
      };
    };

    console = {
      keyMap = "fr";
      colors =
        let
          theme = config.common.theme;
          colors = theme.colors;
        in
        lib.optionals theme.enable (
          map (v: themeUtils.hexColorToHexValue v) [
            "#000000"
            colors.colors.red
            colors.colors.green
            colors.colors.yellow
            colors.colors.blue
            colors.colors.purple
            colors.colors.cyan
            colors.text.primary
            colors.text.muted
            colors.colors_variant.red
            colors.colors_variant.green
            colors.colors_variant.yellow
            colors.colors_variant.blue
            colors.colors_variant.purple
            colors.colors_variant.cyan
            colors.text.primary
          ]
        );

    };

    stylix.targets.console.enable = false;
    stylix.targets.nixos-icons.enable = false;

    ## Hardware config
    # Audio + video
    hardware.graphics.enable = true;

    environment.systemPackages = with pkgs; [
      mesa
      mesa-demos
    ];

    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    services.pulseaudio.enable = false;

    # Enable CUPS to print documents.
    services.printing.enable = true;

    # Bluetooth
    hardware.bluetooth.enable = true; # enables support for Bluetooth
    hardware.bluetooth.powerOnBoot = true;

    ## User config
    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.camille = {
      isNormalUser = true;
      description = "Camille";
      hashedPasswordFile = config.sops.secrets.camille-passwd.path;
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
    };

    virtualisation.docker.enable = true;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "25.05"; # Did you read the comment?
  };
}
