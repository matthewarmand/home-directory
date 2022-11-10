# Home Directory

Repo for dotfiles management and baseline system config.

## Bootstrapping

To set this up on a new machine (or to update one with needed baseline packages),
the following commands can be used:

### Clone This Directory

```shell
cd ~ && git clone git@github.com:matthewarmand/home-directory.git . && git config --local oh-my-zsh.hide-info 1
```

### Baseline Packages

```shell
cd ~ && paru -S --needed -q "$(git ls-files | xargs grep required-arch-packages | awk -F'::' '{print $2}' | tr '\n' ' ')"
```

### OMZ

One of the few things we install outside of Arch packages so it can self-update elegantly
without having to use the `PKGBUILD`

```shell
mkdir -p ~/.oh-my-zsh/ && git clone git@github.com:ohmyzsh/ohmyzsh.git ~/.oh-my-zsh/
```
