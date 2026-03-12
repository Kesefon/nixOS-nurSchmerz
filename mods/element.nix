{ config, pkgs, ... }:

{
  services.nginx.virtualHosts."chat.froggo.garden" = {
    useACMEHost = "froggo-garden";
    forceSSL = true;

    root = pkgs.element-web.override {
      conf = {
        default_server_name = "https://${toString config.services.matrix-tuwunel.settings.global.server_name}";

        default_theme = "dark";
        brand = "🗨️@🐸.🌷";

        mobile_guide_toast = false;
        disable_guests = true;
      };
    };
  };
}
