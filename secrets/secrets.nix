let
  smolbox = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF+4/39z0XZwPUO7iQosEZoENeegtB/WfSmeQqayKiHG
";
  cloudbox = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINBv6a5/4h/HsGLEZm6/TXcB2ZJCp18HHhScpJxpQ3KO";
  servers = [
    smolbox
    cloudbox
  ];
in
{
  "ntfy-token.age".publicKeys = servers;
}
