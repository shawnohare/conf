{
  config,
  nixpkgs,
  pkgs,
  user,
  ...
}: {

  programs.git = {
    enable = true;
    userName = "Shawn O'Hare";
    userEmail = "shawn@shawnohare.com";

    aliases = {
      df = "diff --color-words=. --ws-error-highlight=new,old";
      root = "rev-parse --show-toplevel";
      lg = "log --decorate";
      lga = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
      st = "status";
      sv = "status --verbose";
      sw = "switch";
      newbr = "switch -c";
      unstage = "restore --staged";
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
      };
    };
  };
}
