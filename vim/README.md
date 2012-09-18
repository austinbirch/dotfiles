#My vim configuration.

## Keeping plugins up to date (without Vundle commands)

Although Vundle is used to manage the vim plugins, it shouldn’t be used directly
as it does not play well with submodules. Instead, add a git submodule to the
```vim/bundle``` directory, add the entry to the ```Bundle``` section in
```vimrc```, and then commit the changes.

When vim is restarted, the plugin should work without having to use any of the
Vundle commands (i.e. ```:BundleInstall```).
