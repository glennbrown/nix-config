{ config, inputs, pkgs, lib, unstablePkgs, ... }:
{
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  programs.nix-index.enable = true;
  programs.gpg.enable = true;

  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [ "ignoredups" ];
    shellAliases = {
      l = "ls -alh";
      ll = "ls -lh";
      ls = "ls --color=tty";
      egrep = "egrep --color=auto";
      fgrep = "fgrep --color=auto";
      grep = "grep --color=auto";
      dcp = "docker compose -f ~/compose.yaml ";
      dcporph = "docker compose -f ~/compose.yaml --remove-orphans ";
      dprune = "docker image prune";
      dprunesys = "docker system prune --all";
      drm = "docker rm `docker ps -aq`";
      dstop = "docker stop `docker ps -aq`";
      dtail = "docker logs -tf --tail=50 ";
    };
  };
    
  programs.command-not-found.enable = true;

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = true;
    colors = {
      "bg+" = "-1";
      "fg" = "gray";
      "fg+" = "white";
      "border" = "black";
      "spinner" = "0";
      "hl" = "yellow";
      "header" = "blue";
      "info" = "green";
      "pointer" ="red";
      "marker" = "blue";
      "prompt" = "gray";
      "hl+" = "red";
    };
    defaultOptions = [
      "--height 70%"
      "--border sharp"
      "--layout=reverse"
      "--prompt '∷ '"
      "--pointer ▶"
      "--marker ⇒"
    ];
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  programs.vim = {
    enable = true;
    settings = {
      expandtab = true;
      tabstop = 2;
      shiftwidth = 2;
      number = true;
    };
    extraConfig = ''
      syntax on
      set cursorline
      set nobackup
      set autoread
      set showcmd
      set showmode
      set showmatch
      set autoindent smartindent
      set smarttab
      set scrolloff=5
      filetype on
      filetype indent on
      filetype plugin on
      set autoindent
      set smartindent
      set noerrorbells
      set visualbell
      set hlsearch
      set showmatch
      '';
  };
}
