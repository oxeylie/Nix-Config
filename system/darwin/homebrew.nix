{
  config,
  lib,
  ...
}:
{
  options.homebrew-pkgs = {
    enable = lib.mkEnableOption "Whether to enable the whole homebrew module";
    core = lib.mkEnableOption "Core utilities ?";
    brews = lib.mkEnableOption "Whether to enable brews";
    casks = lib.mkEnableOption "Whether to enable casks";
    mas = lib.mkEnableOption "Whether to enable masApps";
  };

  config = {
    # Pre-activation patches
    system.activationScripts.homebrew.text = lib.mkBefore (
      ''
        echo -e "Running Patches for Homebrew bundle..." >&2
      ''
      + lib.optionalString (builtins.any (c: c.name == "macfuse") config.homebrew.casks) ''
        echo -e "Patching macFuse dependency..." >&2
        touch /usr/local/include/fuse.h
      ''
    );

    homebrew = {
      enable = config.homebrew-pkgs.enable;
      casks =
        lib.optionals config.homebrew-pkgs.core [
          "ghostty"
          "font-sf-pro"
          "BetterDisplay"
        ]
        ++ lib.optionals config.homebrew-pkgs.brews [
          "macfuse"
        ]
        ++ lib.optionals config.homebrew-pkgs.casks [
          # Utilities
          "lulu"
          "knockknock"
          "hex-fiend"
          "deskflow"
          "whisky"
          "the-unarchiver"
          "balenaetcher"
          "suspicious-package"
          "protonvpn"
          "sf-symbols"
          "macusb"
          # "disk-inventory-x"
          "radix"
          # "vorssaint"
          "finetune"
          "sill"
          #"picoscope"

          # Media
          "vlc"
          "kid3"
          "gimp"
          "libreoffice"

          # Other
          "claude"
          "discord"

          # Games
          "steamcmd"
          "steam"
          "gog-galaxy"
        ];
      brews =
        lib.optionals config.homebrew-pkgs.core [
          "dyld-shared-cache-extractor"
        ]
        ++ lib.optionals config.homebrew-pkgs.brews [
          "anylinuxfs"
          "json-c"
          "libunistring"
          "gettext"
          "util-linux"
          "betterdisplaycli"
          "mole"
        ]
        ++ lib.optionals config.homebrew-pkgs.mas [
          "mas"
        ]
        ++ lib.optionals config.home-manager.users.camille.programs.sketchybar.enable [
          "media-control"
        ];

      masApps = lib.mkIf config.homebrew-pkgs.mas {
        actions = 1586435171;
        Ferromagnetic = 1546537151;
        Pdf-Gear = 6469021132;
        prettyJsonSafari = 1445328303;
        Xcode = 497799835;
        wBlock = 6746388723;
      };

      taps = lib.map (name: {
        inherit name;
        trusted = true;
      }) (builtins.attrNames config.nix-homebrew.taps);

      onActivation.autoUpdate = true;
      onActivation.upgrade = true;
      onActivation.cleanup = "zap";
    };
  };
}
