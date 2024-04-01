# Configuration file for ipython.
#
# To generate a new config to see, e.g., all the options, run
# ipython profile create foo
# from ipython.config import Config
# c = Config()
c = get_config()  #noqa

c.TerminalInteractiveShell.auto_match = True
c.TerminalInteractiveShell.editor = "nvim"
c.TerminalInteractiveShell.editing_mode = "vi"
c.TerminalInteractiveShell.true_color = True
# c.Completer.use_jedi = True
