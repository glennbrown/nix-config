{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./../../common/nixos-common-packages.nix
      ./../../common/nixos-common.nix
      (builtins.fetchTarball {
        url = "https://github.com/nix-community/nixos-vscode-server/tarball/master";
        sha256 = "09j4kvsxw1d5dvnhbsgih0icbrxqv90nzf0b589rb5z6gnzwjnqf";
      })
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.systemd-boot.extraInstallCommands = ''
    ${pkgs.coreutils}/bin/cp -r /boot/* /bootbak/
  '';
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "drivetemp" ];
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;
  # boot.kernelParams = [
  #   "i915.fastboot=1"
  #   "i915.enable_guc=3"
  # ];

  boot.supportedFilesystems = [ "zfs" ];
  services.zfs.autoScrub.enable = true;
  
  # zram swap
  zramSwap.enable = true;

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.gbrown = { imports = [ ./../../../home/gbrown.nix ]; };
  users.users.gbrown = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "docker" "render" "video" "libvirtd" ];
    packages = with pkgs; [
      home-manager
    ];
  };
  users.defaultUserShell = pkgs.bash;
  programs.bash.interactiveShellInit = "echo \"\" \n figurine -f \"3d.flf\" nixos-test";

  networking = {
    firewall.enable = false;
    hostId = "3376e411";
    hostName = "nixos-test";
    bridges = {
      br0 = {
        interfaces = [ "enp6s18" ];
      };
    };
    interfaces = {
      br0 = {
        useDHCP = false;
        ipv4.addresses = [ {
          address = "192.168.10.25";
          prefixLength = 24;
        } ];
      };
    };
    defaultGateway = "192.168.10.1";
    nameservers = [ "192.168.10.1" ];
    search = [ "home.ikgb.me" ];
  };

  environment.systemPackages = with pkgs; [
    diceware
    distrobuilder
    ffmpeg
    hddtemp
    intel-gpu-tools
    lm_sensors
    mergerfs
    mergerfs-tools
    nvme-cli
    nvtopPackages.intel
    powertop
    snapraid
    snapper
  ];

  ## quicksync
  hardware.firmware = [ pkgs.linux-firmware ];
  # hardware.opengl = {
  #  enable = true;
  #  extraPackages = with pkgs; [
  #  # VA-API drivers
  #  intel-media-driver  # LIBVA_DRIVER_NAME=iHD
  #  intel-vaapi-driver
  #  libvdpau-va-gl

  #  # OpenCL and compute support
  #  intel-compute-runtime
  #  intel-gmmlib
  #  onevpl-intel-gpu

  #  # VA-API utilities and libraries
  #  libva
  #  libva-utils

  #  # Diagnostic tools
  #  glxinfo
  #  pciutils
  #  ];
  # };
  # environment.sessionVariables = {
  #  LIBVA_DRIVER_NAME = "iHD";
  #  LIBVA_DRIVERS_PATH = "/run/opengl-driver/lib/dri";
  #  LIBVA_MESSAGING_LEVEL = "1";
  #  GST_VAAPI_ALL_DRIVERS = "1";
  # };    

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        vhostUserPackages = [ pkgs.virtiofsd ];
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
      };
    };
  };

  services.fstrim.enable = true;
  services.fwupd.enable = true;
  services.openssh.enable = true;
  #services.tailscale.enable = true;

  services.snapraid = {
    enable = true;
    parityFiles = [
      "/mnt/disks/parity1/snapraid.parity"
    ];
    contentFiles = [
      "/var/snapraid.content"
      "/mnt/snapct/disk1/snapraid.content"
      "/mnt/snapct/disk2/snapraid.content"
    ];
    dataDisks = {
      d1 = "/mnt/disks/disk1";
      d2 = "/mnt/disks/disk2";
      d3 = "/mnt/disks/disk3";
    };
    exclude = [
      "*.unrecoverable"
      "/tmp/"
      "/lost+found/"
      "downloads/"
      "appdata/"
      "*.!sync"
      ".AppleDouble"
      "._AppleDouble"
      ".DS_Store"
      "._.DS_Store"
      ".Thumbs.db"
      ".fseventsd"
      ".Spotlight-V100"
      ".TemporaryItems"
      ".Trashes"
      ".AppleDB"
      ".nfo"
      "/.snapshots/"
    ];
  };

  services.vscode-server.enable = true;

  system.stateVersion = "24.11"; # Did you read the comment?

}

