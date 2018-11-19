# How to Install dotfiles

## Manual install
  1. Backup existing dot files and directories in the home directory. Example:
```
       mv $HOME/.vimrc $HOME/.vimrc.orig
```

  2. Copy links starting with a '.' in 'dotfiles' directory to the home
     directory with 'cp -d'. Example:
```
       cp -d <dotfiles dir>/.vimrc $HOME/
```

  3. Copy and rename directories starting with 'dot' in 'dotfiles' to the home
     directory. Example:
```
       cp -r <dotfiles dir>/dotvim $HOME/
```

## Using bash script install_dotfiles_link

Run install_dotfiles_link:
```
    cd <dotfiles dir>
    bash install_dotfiles_link
```
