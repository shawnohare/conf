
{
  pkgs,
  lib,
  config,
  username,
  ...
}: {
  # Let home-manager manage itself.
  imports = [
    ../modules/git.nix
  ];

  home = {
      username = lib.mkDefault "${username}";
      homeDirectory = lib.mkDefault (if pkgs.stdenv.isDarwin then "/Users/${config.home.username}" else "/home/${config.home.username}");
      stateVersion = lib.mkDefault "23.05";

      # The home.packages option allows you to install Nix packages into your
      # environment.
      packages = [
        # # Adds the 'hello' command to your environment. It prints a friendly
        # # "Hello, world!" when run.
        pkgs.home-manager
        pkgs.hello

        # # It is sometimes useful to fine-tune packages, for example, by applying
        # # overrides. You can do that directly here, just don't forget the
        # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
        # # fonts?
        # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

        # # You can also create simple shell scripts directly inside your
        # # configuration. For example, this adds a command 'my-hello' to your
        # # environment:
        # (pkgs.writeShellScriptBin "my-hello" ''
        #   echo "Hello, ${config.home.username}!"
        # '')
      ];

      # Home Manager is pretty good at managing dotfiles. The primary way to manage
      # plain files is through 'home.file'.
      file = {
        ".profile".source = ../etc/sh/env.sh;
        ".bashrc".source = ../etc/bash/rc.bash;
        ".bash_profile".source = ../etc/bash/profile.bash;
        ".zshenv".source = ../etc/zsh/env.zsh;
        ".config/zsh" = {
            recursive = true;
            source = ../etc/zsh;
        };
        ".config/zsh/.zshrc".source = ../etc/zsh/rc.zsh;
        ".config/" = {
            recursive = true;
            source = ../etc/config;
        };
        ".config/sh" = {
            recursive = true;
            source = ../etc/sh;
        };
        ".local/bin" = {
            recursive = true;
            source = ../bin;
        };
        ".local/bin/switch".source = ../../bin/switch;

        # # You can also set the file content immediately.
        # ".gradle/gradle.properties".text = ''
        #   org.gradle.console=verbose
        #   org.gradle.daemon.idletimeout=3600000
        # '';
      };

      # You can also manage environment variables but you will have to manually
      # source
      #
      #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
      #
      # or
      #
      #  /etc/profiles/per-user/shawn.ohare/etc/profile.d/hm-session-vars.sh
      #
      # if you don't want to manage your shell through Home Manager.
      # NOTE: This likely means enabling the shell in programs and migrating
      # the config.
      sessionVariables = {
        # EDITOR = "emacs";
      };

  };


  # Let Home Manager install and manage itself.
  programs = {
    home-manager = {
        enable = true;
    };
  };

  xdg.enable = true;

}
