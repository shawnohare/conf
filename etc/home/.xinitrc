#!/bin/bash

#based on The X Window User HOWTO:
# 1. startx will start X by first invoking xinit.
# 2. xinit will look for a ~/.xinitrc file in the user's home directory, to run as a shell script.
# 3. xinitrc is used to set up a suitable X environment, and to launch other programs, a.k.a "clients" that we may want available as soon as X is started.
# 4. The Window Manager, or desktop environment, is typically the last application started.
# 5. The other, more common, approach is the "GUI log-in", where X is running before log-in. X includes xdm (X Display Manager) for this purpose.
# 6. Now, ~/.xsessionrc for xdm is the rough equivalent of ~/.xinitrc for startx.
# 7. Depending on how you start X, either the ~/.xinitrc or the ~/.xsessionrc file will be executed by the server.
# 8. Finally, if you execute i3wm from ~/.xinitrc or ~/.xsessionrc, then i3wm will read its initial configuration from ~/.i3/config.!/bin/sh

xrdb -merge ~/.Xresources
source ~/.xsessionrc
