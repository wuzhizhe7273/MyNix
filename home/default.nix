{inputs,...}:
{
  imports=[inputs.home-manager.nixosModules.home-manager ./wanderer];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";
  home-manager.sharedModules=[
    ({config,pkgs,lib,...}:{
      programs={
        home-manager={
          enable=true;
        };
        direnv={
          enable=true;
          enableNushellIntegration=true;
          enableBashIntegration=true;
          nix-direnv.enable=true;
        };
        nushell={
          enable=true;
          extraConfig = ''
            let carapace_completer = {|spans|
            carapace $spans.0 nushell ...$spans | from json
            }
            $env.config = {
              show_banner: false,
              completions: {
                case_sensitive: false # case-sensitive completions
                quick: true    # set to false to prevent auto-selecting completions
                partial: true    # set to false to prevent partial filling of the prompt
                algorithm: "fuzzy"    # prefix or fuzzy
              }
            }
            $env.PATH = ($env.PATH | 
            split row (char esep) |
            append /usr/bin/env
            )
            '';
        };
        git={
          enable=true;
          userName="MyNix";
          userEmail="default@mynix.com";
        };
      };
    })
  ];
  
}