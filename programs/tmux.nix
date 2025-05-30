{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;

    aggressiveResize = true;
    baseIndex = 0;
    clock24 = true;
    customPaneNavigationAndResize = true;
    disableConfirmationPrompt = false;
    escapeTime = 0;
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    reverseSplit = true;
    secureSocket = false;
    sensibleOnTop = true;
    shortcut = "a";
    # For truecolor and styilzed fonts, set terminal to tmux.
    # It seems once pkgs.ncurses is installed there's an appropriate tmux
    # terminfo entry.
    terminal = lib.mkDefault "tmux";
    tmuxp.enable = true;
    tmuxinator.enable = true;

    plugins = [
      # pkgs.tmuxPlugins.battery
      # pkgs.tmuxPlugins.cpu
      pkgs.tmuxPlugins.yank
      # {
      #   plugin = pkgs.tmuxPlugins.resurrect;
      #   extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      # }
    ];

    extraConfig = ''
      bind -T copy-mode-vi 'v' send -X begin-selection
      bind -T copy-mode-vi 'y' send -X copy-pipe-and-cancel !
      bind -T copy-mode-vi 'z' send -X rectangle-toggle
      bind -T copy-mode-vi Escape send -X cancel
      bind -T copy-mode-vi 'x' send -X cancel

      # ---------------------------------
      # colors
      # ---------------------------------
      # Allow truecolors.
      set -as terminal-features ",*:RGB"

      # setw -g monitor-activity on
      # setw -g visual-activity on
      setw -g renumber-windows on
      setw -g allow-rename off
      setw -g status on
      setw -g clock-mode-colour 'default'

      # setw -g display-panes-active-colour colour33
      # setw -g display-panes-colour colour166
      # setw -g message-style 'bg=#073642, fg=green'
      # setw -g pane-border-style 'fg=colour240'
      # setw -g pane-active-border-style 'fg=white'
      setw -g status-style bg=default,fg=default
      setw -g mode-style 'reverse'
      setw -g message-style fg=orange,bg=default
      setw -g message-command-style fg=red,bg=default

      # setw -g status-position 'top'
      # setw -g window-status-style fg=default,bg=default
      setw -g window-status-current-style reverse,bg=default,fg=default
      # setw -g window-style 'bg=colour235,fg=colour253'
      # setw -g window-active-style 'bg=colour235,fg=colour253'
    '';
  };
}
