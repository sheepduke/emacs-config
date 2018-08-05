<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [emacs-settings](#emacs-settings)
- [How to use](#how-to-use)
- [Recover package installation](#recover-package-installation)
- [Directory Hierarchy](#directory-hierarchy)
    - [settings](#settings)
        - [a0-variables](#a0-variables)
        - [a1-function](#a1-function)
        - [b0-customize](#b0-customize)
        - [b1-tools](#b1-tools)
        - [b2-display](#b2-display)
        - [c3-external](#c3-external)
        - [d0-helm](#d0-helm)
        - [d1-dev-common](#d1-dev-common)
        - [d2-dev-lang](#d2-dev-lang)
        - [f4-mail](#f4-mail)
        - [e1-org-mode](#e1-org-mode)
        - [.emacs](#emacs)
    - [data](#data)
        - [yasnippets](#yasnippets)

<!-- markdown-toc end -->

# emacs-settings

This repository contains Emacs settings used by me.

# How to use

Place `settings/.emacs` file to your `home` directory and others to `~/.emacs.d/`, then navigate to `~/.emacs.d/settings/` and run `C-u 0 byte-recompile-directory`.
This will compile `.el` files into byte code (`.elc` files) and thus can be loaded automatically by `~/.emacs` file.

# Recover package installation

Emacs uses variable `package-selected-packages` to store a list of packages installed by the user.

You may `eval` the following snippet to install all packages at once.

```emacs lisp
;; Copy this snippet from `.emacs` file.
(setq package-selected-packages
      (list 
       ;; utility
       'use-package 'elscreen 'auto-compile 'elscreen-persist))
(package-install-selected-packages)
```
# Directory hierarchy

## settings

The place where all configuration and custom plugin (outside elpa) goes.

### a0-variables
Definition of global variables.

### a1-function
Definition of common functions.

### b0-customize
Customization of built-in functionality.

### b1-tools
Small tools that bring much efficiency.

### b2-display
Customization related to buffer display, X window etc.

### c3-external
Tools that relies on external programs.

### d0-helm
`Helm` configuration.

### d1-dev-common
Some common programming configuration.

### d2-dev-lang
Configuration for each programming language.

### f4-mail
Configuration for email.

### e1-org-mode
Org related settings.

### .emacs
Backup for `~/.emacs` file.

## data

Place where all internally used data.

### yasnippets

Place for custom yasnippet.
