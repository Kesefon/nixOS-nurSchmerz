{ config, pkgs, ... }:

{
  config.services.postgresql = {
    enable = true;
    #ensureUsers = [{
    #  name = "postgresql";
    #}];

    #authentication = pkgs.lib.mkOverride 10 ''
    #  #type database  DBuser  auth-method
    #  local sameuser  all     peer
    #'';
  };
}
