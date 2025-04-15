{lib,pkgs,...}:{
  users.users.wanderer={
    isNormalUser=true;
    description="wanderer";
    extraGroups=["networkmanager" "wheel"];
    password="chjh605319";
  };
  home-manager.users.wanderer={
    home.username="wanderer";
    home.homeDirectory= lib.mkForce "/home/wanderer";
    home.stateVersion="24.11";
    programs={
      git={
        enable=lib.mkForce true;
        userName=lib.mkForce "wanderer";
        userEmail=lib.mkForce "1379605319@qq.com";
        extraConfig= lib.mkForce {
          credential.helper = "${pkgs.git.override { withLibsecret = true ;}}/bin/git-credential-libsecret";
        };
      };
    };
  };
}