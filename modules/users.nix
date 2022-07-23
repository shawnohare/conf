# Define custom options for "abstract" users that are not necessarily created.
# This is a workaround for the fact that home-manager, at least as we are
# using it currently, will not match the system user configuration on attribute,
# i.e., the home-user attribute name is used to look for an actual system user
# by attribute but by name
# That is
# users.users.work = {name = "workuser";};
# home-manager.home.users.work = {username = "workuser"};
{
  config,
  pkgs,
  ...
}: {
  options = {
    userProfiles.admin = pkgs.lib.mkOption {
      default = "shawn";
      type = pkgs.lib.types.str;
      description = "Name of admin on personally administered machines / vms.";
    };
    userProfiles.work = pkgs.lib.mkOption {
      default = "user";
      type = pkgs.lib.types.str;
      description = "User name on company provided machines.";
    };
  };
}
