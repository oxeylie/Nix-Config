{ ... }:
{
  imports = [
    ../default.nix
    ./system.nix
    # Include the results of the hardware scan.
    ## [IMPURE]
    # ./hardware-configuration.nix
  ];
}
