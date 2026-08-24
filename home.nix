{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    qtile = "qtile";
    nvim = "nvim";
    alacritty = "alacritty";
    rofi = "rofi";
  };
in
{
home.username = "rayman";
home.homeDirectory = "/home/rayman";
programs.git = {
 enable = true;
 
 userName = "foxy54456";
 userEmail = "135515419+foxy54456@users.noreply.github.com";
};
home.stateVersion = "25.05";
programs.bash = {
enable = true;
shellAliases = {
    btw = "echo i use nixos, btw";
  };
 };


xdg.configFile = builtins.mapAttrs 
  (name: subpath: {
   source = create_symlink"${dotfiles}/${subpath}";
   recursive = true;
}) 
configs;


home.packages = with pkgs; [
 vim
 ripgrep
 nil
 nixpkgs-fmt
 nodejs
 gcc
 rofi
 discord
 mangowc
 waybar
 swaybg
 qimgv
 kdePackages.dolphin
 fastfetch
 vlc
 stremio-linux-shell
 pear-desktop
 cmatrix
 kdePackages.kdenlive
 kdePackages.kate
];
}
