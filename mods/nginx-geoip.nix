{ inputs, pkgs, ... }:

{
  services.nginx = {
    additionalModules = with pkgs.nginxModules; [
      geoip2
    ];

    appendHttpConfig = ''
      geoip2 ${inputs.geolite2-country-mmdb} {
          $geoip2_data_registered_country_code default=XX registered_country iso_code;
          $geoip2_data_registered_country_name registered_country names en;
          $geoip2_data_country_code default=XX country iso_code;
          $geoip2_data_country_name country names en;
          $geoip2_data_continent_code continent code;
          $geoip2_data_continent_name continent names en;
      }

      geoip2 ${inputs.geolite2-city-mmdb} {
          $geoip2_data_city_name   city names en;
          $geoip2_data_subdivision_name  subdivisions 0 names en;
          $geoip2_data_latitude    location latitude;
          $geoip2_data_longitude   location longitude;
          $geoip2_data_accuracy_radius location accuracy_radius;
      }

      geoip2 ${inputs.geolite2-asn-mmdb} {
          $geoip2_data_ASN_number  autonomous_system_number;
          $geoip2_data_ASN_org  autonomous_system_organization;
      }
    '';
  };
}
