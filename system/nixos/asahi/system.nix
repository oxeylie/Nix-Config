{ inputs, ... }:
{
  imports = [
    "${inputs.apple-silicon-support}/default.nix"
  ];

  config = {
    # Bootloader settings
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = false;

    boot.kernelParams = [ "appledrm.show_notch=1" ]; # Enable notch

    hardware.asahi = {
      enable = true;
      avd.enable = true;
      avd.vaapi-support = false;
      inherit (inputs.asahi-vendorfw.lib.hardware.asahi) peripheralFirmwareDirectory;
    };
  };
}
