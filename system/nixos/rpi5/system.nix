{
  config,
  pkgs,
  ...
}:
{
  config = {
    environment.systemPackages =
      with pkgs;
      [
        # Hardware interaction tools
        libgpiod
        i2c-tools
        rpi-keyboard-config
        raspberrypi-utils
        busybox
      ]
      ++ [
        config.boot.kernelPackages.kernel.dev # Might cause long compilation
      ];

    hardware.i2c.enable = true;
    boot.loader.raspberry-pi = {
      enable = true;
      bootloader = "kernel";
    };

    # Export pwm to sysfs
    # hardware.raspberry-pi.config.all = {
    #   dt-overlays.pwm = {
    #     enable = true;
    #     params = {
    #       pin = {
    #         enable = true;
    #         value = 18;
    #       };
    #       func = {
    #         enable = true;
    #         value = 2;
    #       };
    #     };
    #   };
    # };

    # boot.kernelPatches = [
    #   {
    #     name = "allow devmem";
    #     patch = null;
    #     structuredExtraConfig = {
    #       STRICT_DEVMEM = lib.kernel.no;
    #       IO_STRICT_DEVMEM = lib.kernel.no;
    #     };
    #   }
    # ];
  };
}
