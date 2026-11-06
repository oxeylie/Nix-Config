{
  inputs.boot-vendorfw = {
    url = "path:/boot/vendorfw";
    flake = false;
  };

  outputs = inputs: {
    lib.hardware.asahi.peripheralFirmwareDirectory = "${inputs.boot-vendorfw}";
  };
}
