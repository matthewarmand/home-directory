# Home Directory

Repo for dotfiles management and baseline system config.

## Bootstrapping

To set this up on a new machine (or to update one with needed baseline packages),
run the [`bin/.bootstrap.sh`](bin/.bootstrap.sh) script in this repository:

The bootstrap script will clone this repository if it hasn't already been done.
For a first install, you can download that script and run it, or clone the repo
yourself and then run the script from `~/bin/`.

```shell
git clone git@github.com:matthewarmand/home-directory.git ~ && \
source ~/bin/.bootstrap.sh
```
