{
  config,
  nixpkgs,
  pkgs,
  user,
  ...
}: {
  programs.git = {
    enable = true;
    # userName = "Shawn O'Hare";
    # userEmail = "shawn@shawnohare.com";
    lfs.enable = true;

    aliases = {
      df = "diff --color-words=. --ws-error-highlight=new,old";
      lg = "log --decorate";
      lga = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
      ls = "ls-files";
      new = "switch -c";
      root = "rev-parse --show-toplevel";
      st = "status";
      sv = "status --verbose";
      sw = "switch";
      unstage = "restore --staged";
      home = "!git --git-dir=\"\${HOME}/.git/\" --work-tree=\"\${HOME}\"";
    };

    extraConfig = {
      # branch.autosetuprebase = "always";
      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        interactive = "auto";
        ui = true;
        pager = true;
      };
      # core.askPass = ""; # needs to be empty to use terminal for ask pass
      credential.helper = "cache --timeout 604800";
      init = {
        defaultBranch = "master";
      };
      github = {
        user = "shawnohare";
      };
      push = {
        default = "tracking";
        autoSetupRemote = true;
      };
    };
  };
}
