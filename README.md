# How to Install dotfiles
The `install_dotfiles_link` script and the links that will be copied to home
directory assume `<dotfiles dir` to be `$HOME/share/dotfiles`.

## Manual install
  1. Backup existing dot files and directories in the home directory. Example:
```
       mv $HOME/.vimrc $HOME/.vimrc.orig
```

  2. If `<dotfiles dir>` is `$HOME/share/dotfiles`, copy links starting with
     a '.' in 'dotfiles' directory to the home directory with 'cp -d'. Example:
```
       cp -d <dotfiles dir>/.vimrc $HOME/
```
   Otherwise, create links manually using `ln -s`:
```
       cd ~
       ln -s <dotfiles dir>/.vimrc .
```

  3. Copy and rename directories starting with 'dot' in 'dotfiles' to the home
     directory. Example:
```
       cp -r <dotfiles dir>/dotvim $HOME/
```

## Using bash script install_dotfiles_link

If `<dotfiles dir>` is not `$HOME/share/dotfiles`, edit the script `install_dotfiles_link` and modify `dotfile_path` variable accordingly.

Run `install_dotfiles_link`:
```
    cd <dotfiles dir>
    bash install_dotfiles_link
```
