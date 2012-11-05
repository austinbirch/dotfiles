Repo for my various dotfiles

The Rakefile contains useful tasks for symlinking the files into the $USER home
folder.

For tmux to work on OS X, you need to have the 'reattach-to-user-namespace'
binary available in your $PATH. For non-OS X use of tmux.conf, you should remove
the 'reattach-to-user-namespace' lines in the tmux.conf (otherwise it will
fail to use the configuration).

For powerline (providing the bottom bar in Vim), and the tmux status line to
work correctly, you should install the patched font that is included, otherwise
you will get odd symbols rather than arrows.
