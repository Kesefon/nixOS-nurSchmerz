# Monitoring für Arme
# based on https://pascal-wittmann.de/entry/systemd-failure-notification

{ config, pkgs, lib, ... }:
let
  service-fail-alert = pkgs.writeScript "service-fail-alert"
    ''
      #!/usr/bin/env nix-shell
      #! nix-shell -i bash --pure
      #! nix-shell -p bash cacert curl hostname
      curl \
        -H "Authorization: Bearer $(cat ${config.age.secrets.ntfy-token.path})" \
        -d "$1 failed on $(hostname)" \
        https://ntfy.froggo.garden/service-fail-alert
    '';
in

{
  config.age.secrets.ntfy-token.file = ../secrets/ntfy-token.age;

  config.systemd.services."service-fail-alert@" = {
    description = "Send notification on service failure";
    onFailure = lib.mkForce [];
    serviceConfig = {
      ExecStart = "${service-fail-alert} %i";
      Type = "oneshot";
    };
  };

  options.systemd.services = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule {
        config.onFailure = [ "service-fail-alert@%n.service" ];
      }
    );
  };
}
