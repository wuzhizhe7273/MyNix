{pkgs,inputs, ...}:
{
  system.stateVersion = "24.11";
   # 启用 Flakes 特性以及配套的船新 nix 命令行工具
  nix.settings={
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
          "https://cache.flox.dev"
        ];
        trusted-public-keys = [
          "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
        ];
  };
  imports=[inputs.vscode-server.nixosModules.default];
  # vscode server
  services.vscode-server.enable=true;

  environment.systemPackages = with pkgs; [
    # Flakes 通过 git 命令拉取其依赖项，所以必须先安装好 git
    git
    vim
    wget
    fastfetch
    nil
    #dev tool
    inputs.flox.packages.${pkg.system}.default
    nushell
  ];
  # 默认nushell
  users.defaultUserShell=pkgs.nushell;
   # 将默认编辑器设置为 vim
  environment.variables.EDITOR = "vim";
  #启用nix-ld
  programs={
    nix-ld.enable = true;
  };
}
