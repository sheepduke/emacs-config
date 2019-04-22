
# Table of Contents

1.  [Introduction](#orgaac30f9)
2.  [How to Use](#org2b2bdc2)
    1.  [Installation](#org4883faf)
    2.  [Upgrading](#org1f2da37)
3.  [Directory Hierarchy](#org0563bc9)
    1.  [settings](#org5c0c2e8)
    2.  [data](#org05c5f1a)


<a id="orgaac30f9"></a>

# Introduction

This repository contains Emacs settings used by me.


<a id="org2b2bdc2"></a>

# How to Use


<a id="org4883faf"></a>

## Installation

1.  Place `settings/.emacs` file to your `$HOME` directory and others to
    `~/.emacs.d/`.
2.  Open Emacs and run command `package-refresh-contents`.
3.  Navigate to `~/.emacs.d/settings/` and run `C-u 0
       byte-recompile-directory`. This will install all required packages and
    compile `.el` files into byte code (`.elc` files).


<a id="org1f2da37"></a>

## Upgrading

After updating the code, run `C-u 0 byte-recompile-directory` again. This will
automatically install missing packages.

**Tip:**

Emacs uses variable `package-selected-packages` to store a list of packages
installed by the user. You may save this variable and later use function
`(package-install-selected-packages)` to install them back.

However, a better solution might be using `:ensure` feature of `use-package`.


<a id="org0563bc9"></a>

# Directory Hierarchy


<a id="org5c0c2e8"></a>

## settings

The place where all configuration and custom plugin (outside elpa) goes.

-   `.emacs`: Backup for \`~/.emacs\` file.
-   `a0-variables`: Definition of global variables.
-   `a1-functions`: Definition of common functions.
-   `b0-customize`: Customization of built-in functionality.
-   `b1-tools`: Small tools that bring much efficiency.
-   `b2-display`: Customization related to buffer display, X window etc.
-   `c3-external`: Tools that relies on external programs.
-   `d0-helm`: `helm` configuration. You may find `Ivy` related things in
    commit history.
-   `d1-dev-common`: Some common programming configuration.
-   `d2-dev-lang`: Configuration for each programming language.
-   `e1-org-mode`: Org related settings.
-   `f4-mail`: Configuration for Notmuch email client.


<a id="org05c5f1a"></a>

## data

Place where all internally used data.

-   `aspell.en.pws`: Personal dictionary for ispell.
-   `eshell-alias`: Alias definition for eshell.
-   `yasnippets`: Place for custom yasnippet.

