# DOTFILES

These are my dotfiles

## Requirements

Ensure you have the following installed on your system

### Git
```sh
sudo apt install git
```

### Stow
```sh
sudo apt install stow
```

## Usage

Checkout this repo in your $HOME directory using git
```sh
git clone git@github.com:flyingpalli/dotfiles.git
cd dotfiles
```

Then add symlinks with GNU stow
```sh
stow .
```
