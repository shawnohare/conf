# Install the fisherman plugin manager.
# Seems to cause some keybindings to fail, namely reminding CTL-k to up?
if not test -e $XDG_CONFIG_HOME/fish/functions/fisher.fish
  curl -Lo $XDG_CONFIG_HOME/fish/functions/fisher.fish --create-dirs git.io/fisher
end

fish_vi_key_bindings

starship init fish | source

# # Can use starship instead
# set normal (set_color normal)
# set magenta (set_color magenta)
# set yellow (set_color yellow)
# set green (set_color green)
# set red (set_color red)
# set gray (set_color -o black)

# # Fish git prompt
# set __fish_git_prompt_showdirtystate 'yes'
# set __fish_git_prompt_showstashstate 'yes'
# set __fish_git_prompt_showuntrackedfiles 'yes'
# set __fish_git_prompt_showupstream 'yes'
# set __fish_git_prompt_color_branch yellow
# set __fish_git_prompt_color_upstream_ahead green
# set __fish_git_prompt_color_upstream_behind red
# set __fish_git_prompt_color_dirtystate red
# set __fish_git_prompt_color_stagedstate yellow

# # Status Chars
# set __fish_git_prompt_char_dirtystate '*'
# set __fish_git_prompt_char_stagedstate '→'
# set __fish_git_prompt_char_untrackedfiles '☡'
# set __fish_git_prompt_char_stashstate '↩'
# set __fish_git_prompt_char_upstream_ahead '+'
# set __fish_git_prompt_char_upstream_behind '-'


# function fish_prompt
#   set last_status $status

#   set_color $fish_color_cwd
#   printf '%s' (prompt_pwd)
#   set_color normal

#   printf '%s ' (__fish_git_prompt)

#   set_color normal
# end
