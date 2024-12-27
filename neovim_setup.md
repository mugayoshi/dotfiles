# Neovim

## Prerequisites
- Things below are installed
  - Git
  - Homebrew

## Steps

1. Install

```
brew install neovim
```

2. Create config directory

```
mkdir ~/.config
mkdir ~/.config/nvim

```

3. Install required stuff
- Node
- golang
- ripgrep

```
brew install node
brew install go
brew install ripgrep
```

If syntax highlight for Svelte files is necessary, install these by npm.
```
npm install -g typescript typescript-language-server
npm install -g svelte-language-server
```

4. Pull [dotfiles](https://github.com/mugayoshi/dotfiles) repository

5. Open Neovim and it loads plugins automatically
