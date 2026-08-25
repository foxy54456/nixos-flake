{ config, lib, pkgs, nix-cachyos-kernel, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

boot.loader = {
  systemd-boot.enable = false;

  grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
  };

  efi.canTouchEfiVariables = true;
};

  boot.kernelPackages =
    nix-cachyos-kernel.legacyPackages.x86_64-linux.linuxPackages-cachyos-latest;

  networking.hostName = "Nxomb";
  networking.wireless.enable = true;

  time.timeZone = "Europe/Sofia";

  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;

    windowManager.qtile = {
      enable = true;

      package = pkgs.python3.pkgs.qtile.overrideAttrs (old: {
        disabledTests = (old.disabledTests or [ ]) ++ [
          "test_repl_server_executes_code"
        ];
      });
    };
  };

  services.displayManager.ly.enable = true;
  services.desktopManager.plasma6.enable = true;
  users.users.rayman = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;

    packages = with pkgs; [
      tree
    ];
  };
 
  programs.mangowc.enable = true;
  programs.firefox.enable = true;
  programs.steam.enable = true;
  
  hardware.graphics = {
  enable = true;
  enable32Bit = true;
};

 services.xserver.videoDrivers = [ "nvidia" ];

hardware.nvidia = {
    modesetting.enable = true;

    open = false;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
 

  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    alacritty
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.05";
}
