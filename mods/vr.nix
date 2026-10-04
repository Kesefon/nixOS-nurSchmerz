{
  pkgs,
  inputs,
  ...
}:

{
  imports = [ inputs.nixpkgs-xr.nixosModules.nixpkgs-xr ];
  services.monado = {
    enable = true;
    defaultRuntime = true; # Register as default OpenXR runtime
    forceDefaultRuntime = true;
    highPriority = true;
  };

  systemd.user.services.monado.environment = {
    STEAMVR_LH_ENABLE = "0";
    XRT_COMPOSITOR_COMPUTE = "1";
    WMR_HANDTRACKING = "0";
  };

  environment.systemPackages = with pkgs; [
    bs-manager
    xrizer
    openxr-loader
  ];

  programs.steam = {
    package = pkgs.steam.override {
      extraProfile = ''
        # Allows Monado/WiVRn to be used
        export PRESSURE_VESSEL_IMPORT_OPENXR_1_RUNTIMES=1
        # Fixes timezones on VRChat
        unset TZ
        # Allows Monado/WiVRn to be used
        export PRESSURE_VESSEL_FILESYSTEMS_RW=$XDG_RUNTIME_DIR/monado_comp_ipc
        export XDG_CONFIG_DIRS=$XDG_CONFIG_DIRS:${pkgs.monado}/share/
      '';
    };
  };
}
