{ inputs, pkgs, unstablePkgs, ... }:
let
  inherit (inputs) nixpkgs nixpkgs-unstable;
in
{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [

    ## This package list is designed to make a NixOS system as close to base ubuntu-server install as I can
    bash
    bash-completion
    bc
    bcache-tools
    bcachefs-tools
    bolt
    bpftools
    bpftrace
    btop
    btrfs-progs
    busybox
    byobu
    cifs-utils
    coreutils
    cpio
    cpufetch
    cron
    cryptsetup
    curl
    dash
    dbus
    dejavu_fonts
    diffutils
    dig
    dmidecode
    dnsutils
    dosfstools
    e2fsprogs
    ed
    efibootmgr
    eject
    ethtool
    fastfetch
    figurine
    file
    findutils
    fio
    fuse3
    fwupd
    gawk
    gettext
    gh
    git
    git-crypt
    gnugrep
    gnupg
    gnused
    gnutar
    go
    gptfdisk
    groff
    gzip
    hdparm
    host
    htop
    hwdata
    inetutils
    inxi
    iotop
    iperf
    ipmitool
    iproute2
    iptables
    iptables-legacy
    iputils
    isocodes
    iucode-tool
    jq
    just
    kbd
    kmod
    less
    libeatmydata
    lsb-release
    lshw
    lsof
    lvm2
    lvm2_dmeventd
    lvm2_vdo
    man
    mc
    mdadm
    microcode-amd
    microcode-intel
    multipath-tools
    nano
    ncurses
    ncdu
    netcat-openbsd
    nmap
    nfs-utils
    nftables
    nix-bash-completions
    ntfs3g
    numactl
    openssh
    openssl
    p7zip
    p7zip-rar
    parted
    pciutils
    perl
    pipx
    psmisc
    python3
    rsync
    screen
    sg3_utils
    shadow
    squashfsTools
    smartmontools
    strace
    sudo
    sysstat
    tcl
    tcpdump
    time
    tmux
    trace-cmd
    tree
    tzdata
    udisks
    upower
    unzip
    usb-modeswitch
    usb-modeswitch-data
    usbutils
    util-linux
    vim
    virtualenv
    wget
    xfsprogs
    xz
    zerofree
    zip
    zstd
    zsh
    zsh-autosuggestions
    zsh-completions
    zsh-history-substring-search
    
    ## Cool Rust Tools
    diffr # Modern Unix `diff`
    difftastic # Modern Unix `diff`
    du-dust # Modern du
    zoxide # Modern cd replacment
    ripgrep # Modern grep replacement
    fzf # Fuzzy finder
    fd # Find replacement
    dua # Modern Unix `du`
    duf # Modern Unix `df`
    entr # Modern Unix `watch`
    procs # Modern replacement for ps
    tealdeer # Rust re-write of tldr which are community based manpages
    uutils-coreutils # Rust re-write of coreutils
  ];
}
