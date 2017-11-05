# emacs-settings
This repository contains Emacs settings used by me.

I am currently using mu4e for mail client. But the configuration contains some personal information so it is not included here.

# How to Use
Place `.emacs` file to your `home` directory and others to `~/.emacs.d/`, then navigate to `~/.emacs.d/settings/` and run `C-u 0 byte-recompile-directory`.
This will compile `.el` files into byte code and thus can be loaded automatically by `~/.emacs` file.

# Directory Hierarchy
## a0-variables
Definition of global variables.

## a1-function
Definition of common functions.

## b0-customize
Customization of built-in functionality.

## b1-tools
Small tools that bring much efficiency.

## b2-display
Customization related to buffer display, X window etc.

## c3-external
Tools that relies on external programs.

## d0-helm
`Helm` configuration.

## d1-dev-common
Some common programming configuration.

## d2-dev-lang
Configuration for each programming language.

## e1-org-mode
Org related settings.

## .emacs
Backup for `~/.emacs` file.