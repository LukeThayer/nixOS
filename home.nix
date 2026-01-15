{inputs, ...}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.nvf.nixosModules.default
  ];

  programs.nvf = {
    enable = true;
    settings = import ./nvim.nix;
  };

  home-manager = rec {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.luke = users.zach;
    users.zach = {pkgs, ...}: {
      home.stateVersion = "24.11";
      home.sessionVariables = {};
      home.packages = with pkgs; [
        inputs.nix-warez.packages.x86_64-linux.blender_4_2
        webcord
        alacritty
        spotify
        obsidian
        discord
        prismlauncher
        liquidctl
        systemctl-tui
        udisks
        helix
        lunarvim
        alacritty
        fd
        unzip
        zip
        wget
        fzf
        t
        bat
        jq
        usbutils
        can-utils
        flameshot
        nixfmt-rfc-style
        ripgrep
        htop
        tmux
        xfce.thunar
        xfce.thunar-archive-plugin
        xfce.thunar-volman
        xdg-utils
        glib
        dracula-theme
        grim
        slurp
        bemenu
        font-awesome
        nerd-fonts.fira-code
        nerd-fonts.droid-sans-mono
      ];
      programs = {
        chromium.enable = true;
        home-manager.enable = true;
        fish = {
          enable = true;
          interactiveShellInit = "fish_add_path /home/zach/.local/bin:$PATH";
          shellAliases = {
            dev = "nix develop --command bash -c \"nvim ./\"";
            jfu = "sudo journalctl -fu";
            ctl = "sudo systemctl";
          };
        };
        tmux = {
          enable = true;
          terminal = "screen-256color";
          shell = "/etc/profiles/per-user/zthayer/bin/fish";
        };
        git = {
          enable = true;
          lfs.enable = true;
          package = pkgs.gitAndTools.gitFull;
          userName = "Luke Thayer";
          userEmail = "lukemanthayer@gmail.com";
          extraConfig = {
            core.editor = "nvim";
          };
        };
        alacritty = {
          enable = true;
          settings = {
            window = {
              padding = {
                x = 16;
                y = 14;
              };
            };
          };
        };
      };
      home.file = {
        i3 = {
          target = ".config/i3/config";
          source = ./dotfiles/i3/config;
        };
        hypr = {
          recursive = true;
          target = ".config/hypr";
          source = ./dotfiles/hypr;
        };
        waybar = {
          recursive = true;
          target = ".config/waybar";
          source = ./dotfiles/waybar;
        };
        polybar = {
          target = ".config/polybar/config.ini";
          source = ./dotfiles/polybar/config.ini;
        };
        polybar-launch = {
          executable = true;
          target = ".config/polybar/launch.sh";
          source = ./dotfiles/polybar/launch.sh;
        };
      };
    };
  };
}
