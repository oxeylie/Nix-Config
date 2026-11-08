{ pkgs, inputs, ... }:
{
  imports = [
    "${inputs.apple-silicon-support}/default.nix"
  ];

  config = {
    environment.systemPackages = with pkgs; [
      asahi-bless
      asahi-nvram
    ];

    # Bootloader settings
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = false;

    boot.kernelParams = [ "appledrm.show_notch=1" ]; # Enable notch

    hardware.asahi = {
      enable = true;
      avd.enable = true;
      avd.vaapi-support = false;
      peripheralFirmwareDirectory = "${inputs.asahi-vendorfw}";
      # inherit (inputs.asahi-vendorfw.lib.hardware.asahi) peripheralFirmwareDirectory;
    };
  };
}
