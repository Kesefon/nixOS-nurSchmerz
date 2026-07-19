{ globals, ... }:

{
  programs.git = {
    enable = true;
    settings.user.name = "${globals.userinfo.name}";
    settings.user.email = "${globals.userinfo.email}";
    settings.user.signingkey = "~/.ssh/id_ed25519.pub";
    settings.gpg.format = "ssh";
    settings."gpg \"ssh\"".allowedSignersFile = "~/.ssh/allowed_signers";
    settings.commit.gpgsign = true;
    settings.core.editor = "nano";
    settings.color.ui = "auto";
    settings.init.defaultBranch = "miau";
  };
}
