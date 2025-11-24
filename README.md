# dotfiles

This repository is to save files like `.zshrc` and config for Neovim.


## ./local/bin

From https://codeberg.org/EvanHahn/dotfiles

Make sure that there's no `~/.local/bin` and run the following command.
```
ln -s parent_dir/dotfiles/.local/bin ~/.local/bin
```

Add this line to `.bashrc` or the similar file.
```
export PATH="$HOME/.local/bin:$PATH"
```
