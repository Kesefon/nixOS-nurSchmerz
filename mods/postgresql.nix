{ config, pkgs, ... }:

{
  config.services.postgresql = {
    enable = true;
  };
}
