;;; ebuild-mode-keywords.el

;; Copyright 2006-2020 Gentoo Authors

;; Author: Matthew Kennedy <mkennedy@gentoo.org>
;;	Diego Pettenò <flameeyes@gentoo.org>
;;	Christian Faulhammer <fauli@gentoo.org>
;;	Ulrich Müller <ulm@gentoo.org>
;; Maintainer: <emacs@gentoo.org>
;; Keywords: languages

;; This file is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 2 of the License, or
;; (at your option) any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; The commands have been grouped into lists of source (mainly eclass).
;; We map each set of keywords to the basic faces: font-lock-*-face.

;;; Code:

;; Package manager keywords

(defvar ebuild-mode-keywords-0
  '(("assert" "best_version" "debug-print" "debug-print-function"
     "debug-print-section" "die" "diropts" "dobin" "docinto" "doconfd" "dodir"
     "dodoc" "doenvd" "doexe" "doinfo" "doinitd" "doins" "dolib.a" "dolib.so"
     "doman" "domo" "dosbin" "dosym" "ebegin" "econf" "eend" "eerror" "einfo"
     "einfon" "elog" "emake" "ewarn" "exeinto" "exeopts" "fowners" "fperms"
     "has" "hasv" "has_version" "inherit" "insinto" "insopts" "into" "keepdir"
     "newbin" "newconfd" "newdoc" "newenvd" "newexe" "newinitd" "newins"
     "newlib.a" "newlib.so" "newman" "newsbin" "unpack" "use" "usev"
     "use_enable" "use_with")
    font-lock-type-face))

(defvar ebuild-mode-keywords-EAPI
  ;; highlight the EAPI variable itself
  '(("EAPI")
    font-lock-warning-face))

(defvar ebuild-mode-keywords-eapi4
  '(("docompress" "nonfatal")
    font-lock-type-face))

(defvar ebuild-mode-keywords-eapi5
  '(("doheader" "newheader" "usex")
    font-lock-type-face))

(defvar ebuild-mode-keywords-eapi6
  '(("eapply" "eapply_user" "einstalldocs" "get_libdir" "in_iuse")
    font-lock-type-face))

(defvar ebuild-mode-keywords-eapi7
  '(("dostrip" "eqawarn" "ver_cut" "ver_rs" "ver_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-functions
  '(("pkg_nofetch" "pkg_setup" "src_unpack" "src_compile" "src_test"
     "src_install" "pkg_preinst" "pkg_postinst" "pkg_prerm" "pkg_postrm"
     "pkg_config")
    font-lock-type-face))

(defvar ebuild-mode-keywords-functions-eapi2
  '(("pkg_info" "src_prepare" "src_configure")
    font-lock-type-face))

(defvar ebuild-mode-keywords-functions-eapi4
  '(("pkg_pretend")
    font-lock-type-face))

(defvar ebuild-mode-keywords-functions-default
  '(("default" "default_pkg_nofetch" "default_src_unpack"
     "default_src_prepare" "default_src_configure" "default_src_compile"
     "default_src_test" "default_src_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-sandbox
  '(("adddeny" "addpredict" "addread" "addwrite")
    font-lock-warning-face))

(defvar ebuild-mode-keywords-eapi-deprecated
  ;; deprecated or banned package manager commands
  '(("dohard" "dohtml" "dolib" "dosed" "einstall" "hasq" "libopts"
     "prepalldocs" "prepall" "prepallinfo" "prepallman" "prepallstrip" "useq")
    font-lock-warning-face))

;; Eclass keywords

;; comment-face will always override the eclass documentation strings
(defvar ebuild-mode-keywords-eclass-documentation
  '(("@AUTHOR" "@BLURB" "@BUGREPORTS" "@CODE" "@DEAD" "@DEFAULT_UNSET"
     "@DESCRIPTION" "@ECLASS" "@ECLASS-VARIABLE" "@EXAMPLE" "@FUNCTION"
     "@INTERNAL" "@MAINTAINER" "@OUTPUT_VARIABLE" "@PRE_INHERIT" "@REQUIRED"
     "@RETURN" "@ROFF" "@SUPPORTED_EAPIS" "@USAGE" "@USER_VARIABLE"
     "@VARIABLE" "@VCSURL")
    font-lock-type-face))

(defvar ebuild-mode-keywords-warn
  ;; warn about "which" usage
  ;; see http://permalink.gmane.org/gmane.linux.gentoo.devel/46770
  '(("which" "bindnow-flags" "has_m64" "has_m32")
    font-lock-warning-face))

(defvar ebuild-mode-keywords-eclass-deprecated
  ;; deprecated eclass functions
  '(("bash-completion_pkg_postinst" "dobashcompletion" "elisp-comp"
     "elisp-need-emacs" "python_mod_compile" "qt4_min_version"
     "qt4_min_version_list")
    font-lock-warning-face))

;; All keyword lists below this line are auto-generated
;; from keyword-generation.sh

;; @@KEYWORDS-BEGIN@@
(defvar ebuild-mode-keywords-acct-group
  '(("acct-group_pkg_preinst" "acct-group_pkg_pretend"
     "acct-group_src_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-acct-user
  '(("acct-user_add_deps" "acct-user_pkg_postinst" "acct-user_pkg_preinst"
     "acct-user_pkg_prerm" "acct-user_pkg_pretend" "acct-user_src_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-ada
  '(("ada_export" "ada_pkg_setup" "ada_setup" "ada_wrapper_setup")
    font-lock-type-face))

(defvar ebuild-mode-keywords-alternatives
  '(("alternatives_auto_makesym" "alternatives_makesym"
     "alternatives_pkg_postinst" "alternatives_pkg_postrm")
    font-lock-type-face))

(defvar ebuild-mode-keywords-ant-tasks
  '(("ant-tasks_src_compile" "ant-tasks_src_install" "ant-tasks_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-apache-2
  '(("apache-2_pkg_postinst" "apache-2_pkg_setup" "apache-2_src_configure"
     "apache-2_src_install" "apache-2_src_prepare" "check_module_critical"
     "check_upgrade" "generate_load_module" "setup_modules" "setup_mpm")
    font-lock-type-face))

(defvar ebuild-mode-keywords-apache-module
  '(("apache-module_pkg_postinst" "apache-module_src_compile"
     "apache-module_src_install" "apache_cd_dir" "apache_doc_magic"
     "apache_mod_file")
    font-lock-type-face))

(defvar ebuild-mode-keywords-aspell-dict-r1
  '(("aspell-dict-r1_src_configure" "aspell-dict-r1_src_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-autotools
  '(("autotools_check_macro" "autotools_m4dir_include"
     "autotools_m4sysdir_include" "config_rpath_update" "eaclocal"
     "eaclocal_amflags" "eautoconf" "eautoheader" "eautomake" "eautopoint"
     "eautoreconf")
    font-lock-type-face))

(defvar ebuild-mode-keywords-autotools-utils
  '(("autotools-utils_src_compile" "autotools-utils_src_configure"
     "autotools-utils_src_install" "autotools-utils_src_prepare"
     "autotools-utils_src_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-base
  '(("base_src_compile" "base_src_configure" "base_src_install"
     "base_src_install_docs" "base_src_make" "base_src_prepare"
     "base_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-bash-completion-r1
  '(("bashcomp_alias" "dobashcomp" "get_bashcompdir" "newbashcomp")
    font-lock-type-face))

(defvar ebuild-mode-keywords-bazel
  '(("bazel_get_flags" "bazel_load_distfiles" "bazel_setup_bazelrc" "ebazel")
    font-lock-type-face))

(defvar ebuild-mode-keywords-cannadic
  '(("cannadic-install" "cannadic_pkg_postinst" "cannadic_pkg_postrm"
     "cannadic_pkg_setup" "cannadic_src_install" "dicsdir-install"
     "update-cannadic-dir")
    font-lock-type-face))

(defvar ebuild-mode-keywords-cargo
  '(("cargo_crate_uris" "cargo_gen_config" "cargo_live_src_unpack"
     "cargo_src_compile" "cargo_src_configure" "cargo_src_install"
     "cargo_src_test" "cargo_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-cdrom
  '(("cdrom_get_cds" "cdrom_load_next_cd")
    font-lock-type-face))

(defvar ebuild-mode-keywords-check-reqs
  '(("check-reqs_pkg_pretend" "check-reqs_pkg_setup" "check_reqs")
    font-lock-type-face))

(defvar ebuild-mode-keywords-chromium-2
  '(("chromium_pkg_die" "chromium_remove_language_paks"
     "chromium_suid_sandbox_check_kernel_config" "egyp_chromium" "gyp_use")
    font-lock-type-face))

(defvar ebuild-mode-keywords-cmake
  '(("cmake_build" "cmake_comment_add_subdirectory" "cmake_run_in"
     "cmake_src_compile" "cmake_src_configure" "cmake_src_install"
     "cmake_src_prepare" "cmake_src_test" "cmake_use_find_package")
    font-lock-type-face))

(defvar ebuild-mode-keywords-cmake-multilib
  '(("cmake-multilib_src_compile" "cmake-multilib_src_configure"
     "cmake-multilib_src_install" "cmake-multilib_src_test"
     "multilib_src_compile" "multilib_src_configure" "multilib_src_install"
     "multilib_src_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-cmake-utils
  '(("cmake-utils_src_compile" "cmake-utils_src_configure"
     "cmake-utils_src_install" "cmake-utils_src_make"
     "cmake-utils_src_prepare" "cmake-utils_src_test" "cmake-utils_use"
     "cmake-utils_use_build" "cmake-utils_use_disable"
     "cmake-utils_use_enable" "cmake-utils_use_find_package"
     "cmake-utils_use_has" "cmake-utils_use_no" "cmake-utils_use_use"
     "cmake-utils_use_want" "cmake-utils_use_with" "cmake-utils_useno"
     "cmake_comment_add_subdirectory" "cmake_use_find_package"
     "comment_add_subdirectory")
    font-lock-type-face))

(defvar ebuild-mode-keywords-common-lisp-3
  '(("absolute-path-p" "common-lisp-3_src_compile" "common-lisp-3_src_install"
     "common-lisp-export-impl-args" "common-lisp-find-lisp-impl"
     "common-lisp-get-fpredicate" "common-lisp-install-asdf"
     "common-lisp-install-one-asdf" "common-lisp-install-one-source"
     "common-lisp-install-sources" "lisp-file-p")
    font-lock-type-face))

(defvar ebuild-mode-keywords-cron
  '(("cron_pkg_postinst" "docron" "docrondir" "docrontab")
    font-lock-type-face))

(defvar ebuild-mode-keywords-cuda
  '(("cuda_add_sandbox" "cuda_cudnn_version" "cuda_gccdir" "cuda_sanitize"
     "cuda_src_prepare" "cuda_toolkit_version")
    font-lock-type-face))

(defvar ebuild-mode-keywords-cvs
  '(("cvs_fetch" "cvs_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-darcs
  '(("darcs_fetch" "darcs_patchcount" "darcs_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-db
  '(("db_fix_so" "db_src_install_doc" "db_src_install_examples"
     "db_src_install_headerslot" "db_src_install_usrbinslot"
     "db_src_install_usrlibcleanup" "db_src_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-db-use
  '(("db_findver" "db_includedir" "db_libname" "db_ver_to_slot")
    font-lock-type-face))

(defvar ebuild-mode-keywords-depend.apache
  '(("depend.apache_pkg_setup" "has_apache" "has_apache_threads"
     "has_apache_threads_in" "need_apache" "need_apache2" "need_apache2_2"
     "need_apache2_4" "want_apache" "want_apache2" "want_apache2_2"
     "want_apache2_4")
    font-lock-type-face))

(defvar ebuild-mode-keywords-desktop
  '(("doicon" "domenu" "make_desktop_entry" "make_session_desktop" "newicon"
     "newmenu")
    font-lock-type-face))

(defvar ebuild-mode-keywords-dist-kernel-utils
  '(("dist-kernel_build_initramfs" "dist-kernel_get_image_path"
     "dist-kernel_install_kernel" "dist-kernel_reinstall_initramfs")
    font-lock-type-face))

(defvar ebuild-mode-keywords-distutils-r1
  '(("distutils-r1_python_compile" "distutils-r1_python_configure"
     "distutils-r1_python_install" "distutils-r1_python_install_all"
     "distutils-r1_python_prepare" "distutils-r1_python_prepare_all"
     "distutils-r1_python_test" "distutils-r1_src_compile"
     "distutils-r1_src_configure" "distutils-r1_src_install"
     "distutils-r1_src_prepare" "distutils-r1_src_test"
     "distutils_enable_sphinx" "distutils_enable_tests"
     "distutils_install_for_testing" "esetup.py")
    font-lock-type-face))

(defvar ebuild-mode-keywords-docs
  '(("docs_compile")
    font-lock-type-face))

(defvar ebuild-mode-keywords-dotnet
  '(("dotnet_multilib_comply" "dotnet_pkg_setup" "egacinstall" "exbuild")
    font-lock-type-face))

(defvar ebuild-mode-keywords-dune
  '(("dune-install" "dune_src_compile" "dune_src_install" "dune_src_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-eapi7-ver
  '(("ver_cut" "ver_rs" "ver_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-eapi8-dosym
  '(("dosym8")
    font-lock-type-face))

(defvar ebuild-mode-keywords-ecm
  '(("ecm_pkg_postinst" "ecm_pkg_postrm" "ecm_pkg_preinst" "ecm_pkg_pretend"
     "ecm_pkg_setup" "ecm_punt_bogus_dep" "ecm_src_compile"
     "ecm_src_configure" "ecm_src_install" "ecm_src_prepare" "ecm_src_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-edos2unix
  '(("edos2unix")
    font-lock-type-face))

(defvar ebuild-mode-keywords-elisp
  '(("elisp_pkg_postinst" "elisp_pkg_postrm" "elisp_pkg_setup"
     "elisp_src_compile" "elisp_src_configure" "elisp_src_install"
     "elisp_src_prepare" "elisp_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-elisp-common
  '(("elisp-check-emacs-version" "elisp-compile" "elisp-emacs-version"
     "elisp-install" "elisp-make-autoload-file" "elisp-modules-install"
     "elisp-need-emacs" "elisp-site-file-install" "elisp-site-regen")
    font-lock-type-face))

(defvar ebuild-mode-keywords-emboss-r2
  '(("emboss-r2_src_configure" "emboss-r2_src_install"
     "emboss-r2_src_prepare")
    font-lock-type-face))

(defvar ebuild-mode-keywords-epatch
  '(("epatch" "epatch_user")
    font-lock-type-face))

(defvar ebuild-mode-keywords-estack
  '(("eshopts_pop" "eshopts_push" "estack_pop" "estack_push" "eumask_pop"
     "eumask_push" "evar_pop" "evar_push" "evar_push_set")
    font-lock-type-face))

(defvar ebuild-mode-keywords-eutils
  '(("einstalldocs" "emktemp" "eqawarn" "in_iuse" "path_exists" "use_if_iuse"
     "usex")
    font-lock-type-face))

(defvar ebuild-mode-keywords-fcaps
  '(("fcaps" "fcaps_pkg_postinst")
    font-lock-type-face))

(defvar ebuild-mode-keywords-findlib
  '(("check_ocamlfind" "findlib_src_install" "findlib_src_preinst")
    font-lock-type-face))

(defvar ebuild-mode-keywords-fixheadtails
  '(("ht_fix_all" "ht_fix_file")
    font-lock-type-face))

(defvar ebuild-mode-keywords-flag-o-matic
  '(("all-flag-vars" "append-cflags" "append-cppflags" "append-cxxflags"
     "append-fflags" "append-flags" "append-ldflags" "append-lfs-flags"
     "append-libs" "filter-flags" "filter-ldflags" "filter-lfs-flags"
     "filter-mfpmath" "get-flag" "is-flag" "is-flagq" "is-ldflag" "is-ldflagq"
     "no-as-needed" "raw-ldflags" "replace-cpu-flags" "replace-flags"
     "replace-sparc64-flags" "setup-allowed-flags" "strip-flags"
     "strip-unsupported-flags" "test-flag-CC" "test-flag-CCLD" "test-flag-CXX"
     "test-flag-F77" "test-flag-FC" "test-flag-PROG" "test-flags"
     "test-flags-CC" "test-flags-CCLD" "test-flags-CXX" "test-flags-F77"
     "test-flags-FC" "test-flags-PROG" "test_version_info")
    font-lock-type-face))

(defvar ebuild-mode-keywords-font
  '(("font_cleanup_dirs" "font_fontconfig" "font_pkg_postinst"
     "font_pkg_postrm" "font_pkg_setup" "font_src_install"
     "font_xfont_config")
    font-lock-type-face))

(defvar ebuild-mode-keywords-font-ebdftopcf
  '(("ebdftopcf" "font-ebdftopcf_src_compile")
    font-lock-type-face))

(defvar ebuild-mode-keywords-fortran-2
  '(("fortran-2_pkg_setup" "fortran_int64_abi_fflags")
    font-lock-type-face))

(defvar ebuild-mode-keywords-freedict
  '(("freedict_src_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-games
  '(("dogamesbin" "dogameslib" "dogameslib.a" "dogameslib.so" "dogamessbin"
     "egamesconf" "games_get_libdir" "games_make_wrapper" "games_pkg_postinst"
     "games_pkg_preinst" "games_pkg_setup" "games_src_compile"
     "games_src_configure" "games_umod_unpack" "games_ut_unpack" "gamesowners"
     "gamesperms" "newgamesbin" "newgamessbin" "prepgamesdirs")
    font-lock-type-face))

(defvar ebuild-mode-keywords-ghc-package
  '(("check-for-collisions" "ghc-cabal-version" "ghc-confdir"
     "ghc-extractportageversion" "ghc-getghc" "ghc-getghcpkg"
     "ghc-getghcpkgbin" "ghc-install-pkg" "ghc-is-dynamic" "ghc-libdir"
     "ghc-localpkgconfd" "ghc-make-args" "ghc-package-db" "ghc-package-exists"
     "ghc-package_pkg_postinst" "ghc-package_pkg_postrm"
     "ghc-package_pkg_prerm" "ghc-pkgdeps" "ghc-pm-version" "ghc-recache-db"
     "ghc-register-pkg" "ghc-reregister" "ghc-supports-interpreter"
     "ghc-supports-parallel-make" "ghc-supports-shared-libraries"
     "ghc-supports-smp" "ghc-supports-threaded-runtime" "ghc-unregister-pkg"
     "ghc-version")
    font-lock-type-face))

(defvar ebuild-mode-keywords-git-r3
  '(("git-r3_checkout" "git-r3_fetch" "git-r3_peek_remote_ref"
     "git-r3_pkg_needrebuild" "git-r3_src_fetch" "git-r3_src_unpack"
     "pkg_needrebuild")
    font-lock-type-face))

(defvar ebuild-mode-keywords-gkrellm-plugin
  '(("gkrellm-plugin_src_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-gnome2
  '(("gnome2_pkg_postinst" "gnome2_pkg_postrm" "gnome2_pkg_preinst"
     "gnome2_src_compile" "gnome2_src_configure" "gnome2_src_install"
     "gnome2_src_prepare" "gnome2_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-gnome2-utils
  '(("gnome2_disable_deprecation_warning" "gnome2_environment_reset"
     "gnome2_gconf_install" "gnome2_gconf_savelist" "gnome2_gconf_uninstall"
     "gnome2_gdk_pixbuf_savelist" "gnome2_gdk_pixbuf_update"
     "gnome2_giomodule_cache_update" "gnome2_omf_fix"
     "gnome2_query_immodules_gtk2" "gnome2_query_immodules_gtk3"
     "gnome2_schemas_savelist" "gnome2_schemas_update"
     "gnome2_scrollkeeper_savelist" "gnome2_scrollkeeper_update")
    font-lock-type-face))

(defvar ebuild-mode-keywords-gnuconfig
  '(("gnuconfig_do_update" "gnuconfig_findnewest" "gnuconfig_update")
    font-lock-type-face))

(defvar ebuild-mode-keywords-gnustep-base
  '(("egnustep_doc" "egnustep_env" "egnustep_install"
     "egnustep_install_config" "egnustep_make" "gnustep-base_pkg_postinst"
     "gnustep-base_pkg_setup" "gnustep-base_src_compile"
     "gnustep-base_src_configure" "gnustep-base_src_install"
     "gnustep-base_src_prepare" "gnustep-base_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-go-module
  '(("go-module_live_vendor" "go-module_pkg_postinst" "go-module_set_globals"
     "go-module_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-golang-base
  '(("ego_pn_check" "get_golibdir" "get_golibdir_gopath"
     "golang_install_pkgs")
    font-lock-type-face))

(defvar ebuild-mode-keywords-golang-build
  '(("golang-build_src_compile" "golang-build_src_install"
     "golang-build_src_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-golang-vcs
  '(("golang-vcs_src_fetch" "golang-vcs_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-golang-vcs-snapshot
  '(("golang-vcs-snapshot_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-gstreamer
  '(("gstreamer_multilib_src_compile" "gstreamer_multilib_src_configure"
     "gstreamer_multilib_src_install" "gstreamer_multilib_src_install_all"
     "gstreamer_system_link" "multilib_src_configure")
    font-lock-type-face))

(defvar ebuild-mode-keywords-haskell-cabal
  '(("cabal-bootstrap" "cabal-build" "cabal-configure" "cabal-constraint"
     "cabal-copy" "cabal-die-if-nonempty" "cabal-haddock" "cabal-hscolour"
     "cabal-is-dummy-lib" "cabal-mksetup" "cabal-pkg" "cabal-show-brokens"
     "cabal-show-brokens-and-die" "cabal-show-old" "cabal-version"
     "cabal_chdeps" "cabal_flag" "cabal_src_compile" "cabal_src_configure"
     "cabal_src_install" "haskell-cabal-run_verbose"
     "haskell-cabal_pkg_postinst" "haskell-cabal_pkg_postrm"
     "haskell-cabal_pkg_setup" "haskell-cabal_src_compile"
     "haskell-cabal_src_configure" "haskell-cabal_src_install"
     "haskell-cabal_src_test" "replace-hcflags")
    font-lock-type-face))

(defvar ebuild-mode-keywords-java-ant-2
  '(("java-ant-2_src_configure" "java-ant_bsfix_files" "java-ant_bsfix_one"
     "java-ant_ignore-system-classes" "java-ant_rewrite-bootclasspath"
     "java-ant_rewrite-classpath" "java-ant_xml-rewrite")
    font-lock-type-face))

(defvar ebuild-mode-keywords-java-osgi
  '(("java-osgi_dojar" "java-osgi_dojar-fromfile" "java-osgi_newjar"
     "java-osgi_newjar-fromfile")
    font-lock-type-face))

(defvar ebuild-mode-keywords-java-pkg-2
  '(("java-pkg-2_pkg_preinst" "java-pkg-2_pkg_setup" "java-pkg-2_src_compile"
     "java-pkg-2_src_prepare" "java-pkg-2_src_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-java-pkg-opt-2
  '(("java-pkg-opt-2_pkg_preinst" "java-pkg-opt-2_pkg_setup"
     "java-pkg-opt-2_src_prepare")
    font-lock-type-face))

(defvar ebuild-mode-keywords-java-pkg-simple
  '(("java-pkg-simple_src_compile" "java-pkg-simple_src_install"
     "java-pkg-simple_src_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-java-utils-2
  '(("eant" "ejavac" "ejavadoc" "ejunit" "ejunit4" "increment-qa-violations"
     "is-java-strict" "java-pkg_addcp" "java-pkg_addres"
     "java-pkg_announce-qa-violation" "java-pkg_check-jikes"
     "java-pkg_check-phase" "java-pkg_check-versioned-jar" "java-pkg_clean"
     "java-pkg_current-vm-matches" "java-pkg_doexamples" "java-pkg_dohtml"
     "java-pkg_dojar" "java-pkg_dojavadoc" "java-pkg_dolauncher"
     "java-pkg_doso" "java-pkg_dosrc" "java-pkg_dowar" "java-pkg_ensure-gcj"
     "java-pkg_ensure-no-bundled-jars" "java-pkg_ensure-test"
     "java-pkg_filter-compiler" "java-pkg_find-normal-jars"
     "java-pkg_force-compiler" "java-pkg_get-bootclasspath"
     "java-pkg_get-javac" "java-pkg_get-jni-cflags" "java-pkg_get-source"
     "java-pkg_get-target" "java-pkg_getjar" "java-pkg_getjars"
     "java-pkg_init-compiler_" "java-pkg_init_paths_" "java-pkg_jar-from"
     "java-pkg_jar-list" "java-pkg_jarfrom" "java-pkg_jarinto"
     "java-pkg_javac-args" "java-pkg_newjar" "java-pkg_register-ant-task"
     "java-pkg_register-dependency" "java-pkg_register-environment-variable"
     "java-pkg_register-optional-dependency" "java-pkg_regjar"
     "java-pkg_regso" "java-pkg_rm_files" "java-pkg_set-current-vm"
     "java-pkg_sointo" "java-utils-2_pkg_preinst" "java-utils-2_src_prepare"
     "use_doc")
    font-lock-type-face))

(defvar ebuild-mode-keywords-java-virtuals-2
  '(("java-virtuals-2_do_write" "java-virtuals-2_src_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-java-vm-2
  '(("get_system_arch" "java-vm-2_pkg_postinst" "java-vm-2_pkg_postrm"
     "java-vm-2_pkg_prerm" "java-vm-2_pkg_setup" "java-vm_install-env"
     "java-vm_revdep-mask" "java-vm_sandbox-predict"
     "java-vm_set-pax-markings" "set_java_env")
    font-lock-type-face))

(defvar ebuild-mode-keywords-kde.org
  '(("kde.org_pkg_nofetch" "kde.org_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-kernel-2
  '(("compile_headers" "compile_headers_tweak_config" "cross_pre_c_headers"
     "debug-print-kernel2-variables" "detect_arch" "detect_version"
     "env_setup_xmakeopts" "getfilevar" "handle_genpatches" "headers___fix"
     "install_headers" "install_sources" "install_universal"
     "kernel-2_pkg_postinst" "kernel-2_pkg_postrm" "kernel-2_pkg_preinst"
     "kernel-2_pkg_setup" "kernel-2_src_compile" "kernel-2_src_install"
     "kernel-2_src_prepare" "kernel-2_src_test" "kernel-2_src_unpack"
     "kernel_header_destdir" "kernel_is" "kernel_is_2_4" "kernel_is_2_6"
     "postinst_sources" "preinst_headers" "setup_headers" "unipatch"
     "universal_unpack" "unpack_2_4" "unpack_2_6" "unpack_fix_install_path"
     "unpack_set_extraversion")
    font-lock-type-face))

(defvar ebuild-mode-keywords-kernel-build
  '(("kernel-build_merge_configs" "kernel-build_pkg_postinst"
     "kernel-build_src_compile" "kernel-build_src_configure"
     "kernel-build_src_install" "kernel-build_src_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-kernel-install
  '(("kernel-install_can_update_symlink" "kernel-install_create_init"
     "kernel-install_create_qemu_image" "kernel-install_get_qemu_arch"
     "kernel-install_install_all" "kernel-install_pkg_config"
     "kernel-install_pkg_postinst" "kernel-install_pkg_postrm"
     "kernel-install_pkg_preinst" "kernel-install_pkg_prerm"
     "kernel-install_pkg_pretend" "kernel-install_src_test"
     "kernel-install_test" "kernel-install_update_symlink")
    font-lock-type-face))

(defvar ebuild-mode-keywords-kodi-addon
  '(("kodi-addon_src_configure")
    font-lock-type-face))

(defvar ebuild-mode-keywords-l10n
  '(("l10n_find_plocales_changes" "l10n_for_each_disabled_locale_do"
     "l10n_for_each_locale_do" "l10n_get_locales" "strip-linguas")
    font-lock-type-face))

(defvar ebuild-mode-keywords-latex-package
  '(("latex-package_pkg_postinst" "latex-package_pkg_postrm"
     "latex-package_rehash" "latex-package_src_compile"
     "latex-package_src_doinstall" "latex-package_src_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-libretro-core
  '(("libretro-core_src_compile" "libretro-core_src_install"
     "libretro-core_src_prepare" "libretro-core_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-libtool
  '(("darwintoolize" "elibtoolize" "uclibctoolize")
    font-lock-type-face))

(defvar ebuild-mode-keywords-linux-info
  '(("check_extra_config" "check_kernel_built" "check_modules_supported"
     "check_zlibinflate" "get_localversion" "get_makefile_extract_function"
     "get_running_version" "get_version" "getfilevar" "getfilevar_noexec"
     "kernel_is" "linux-info_get_any_version" "linux-info_pkg_setup"
     "linux_chkconfig_builtin" "linux_chkconfig_module"
     "linux_chkconfig_present" "linux_chkconfig_string"
     "linux_config_bin_exists" "linux_config_exists" "linux_config_path"
     "linux_config_qa_check" "linux_config_src_exists" "qeerror" "qeinfo"
     "qewarn" "qout" "require_configured_kernel" "set_arch_to_kernel"
     "set_arch_to_portage")
    font-lock-type-face))

(defvar ebuild-mode-keywords-linux-mod
  '(("check_vermagic" "convert_to_m" "find_module_params" "generate_modulesd"
     "get-KERNEL_CC" "linux-mod_pkg_postinst" "linux-mod_pkg_postrm"
     "linux-mod_pkg_preinst" "linux-mod_pkg_setup"
     "linux-mod_pkg_setup_binary" "linux-mod_src_compile"
     "linux-mod_src_install" "move_old_moduledb" "remove_moduledb" "set_kvobj"
     "strip_modulenames" "update_depmod" "update_moduledb" "use_m")
    font-lock-type-face))

(defvar ebuild-mode-keywords-llvm
  '(("get_llvm_prefix" "llvm_pkg_setup")
    font-lock-type-face))

(defvar ebuild-mode-keywords-llvm.org
  '(("get_lit_flags" "llvm.org_set_globals" "llvm.org_src_prepare"
     "llvm.org_src_unpack" "llvm_are_manpages_built" "llvm_install_manpages")
    font-lock-type-face))

(defvar ebuild-mode-keywords-ltprune
  '(("prune_libtool_files")
    font-lock-type-face))

(defvar ebuild-mode-keywords-lua
  '(("lua_copy_sources" "lua_foreach_impl")
    font-lock-type-face))

(defvar ebuild-mode-keywords-lua-single
  '(("lua-single_pkg_setup" "lua_gen_cond_dep" "lua_gen_impl_dep" "lua_setup")
    font-lock-type-face))

(defvar ebuild-mode-keywords-lua-utils
  '(("lua_enable_tests" "lua_get_CFLAGS" "lua_get_LIBS" "lua_get_cmod_dir"
     "lua_get_include_dir" "lua_get_lmod_dir" "lua_get_shared_lib"
     "lua_get_version")
    font-lock-type-face))

(defvar ebuild-mode-keywords-mate
  '(("ematedocize" "mate_pkg_postinst" "mate_pkg_postrm" "mate_pkg_preinst"
     "mate_py_cond_func_wrap" "mate_src_configure" "mate_src_install"
     "mate_src_prepare" "want_mate_doc")
    font-lock-type-face))

(defvar ebuild-mode-keywords-mercurial
  '(("mercurial_fetch" "mercurial_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-meson
  '(("meson_feature" "meson_src_compile" "meson_src_configure"
     "meson_src_install" "meson_src_test" "meson_use")
    font-lock-type-face))

(defvar ebuild-mode-keywords-mono
  '(("egacinstall" "mono_multilib_comply")
    font-lock-type-face))

(defvar ebuild-mode-keywords-mono-env
  '(("mono-env_pkg_setup")
    font-lock-type-face))

(defvar ebuild-mode-keywords-mount-boot
  '(("mount-boot_pkg_postinst" "mount-boot_pkg_postrm"
     "mount-boot_pkg_preinst" "mount-boot_pkg_prerm" "mount-boot_pkg_pretend")
    font-lock-type-face))

(defvar ebuild-mode-keywords-mozcoreconf-v5
  '(("moz_pkgsetup" "mozconfig_annotate" "mozconfig_final" "mozconfig_init"
     "mozconfig_use_enable" "mozconfig_use_extension" "mozconfig_use_with")
    font-lock-type-face))

(defvar ebuild-mode-keywords-mozcoreconf-v6
  '(("moz_pkgsetup" "mozconfig_annotate" "mozconfig_final" "mozconfig_init"
     "mozconfig_use_enable" "mozconfig_use_extension" "mozconfig_use_with")
    font-lock-type-face))

(defvar ebuild-mode-keywords-mozextension
  '(("mozversion_extension_location" "xpi_copy" "xpi_install" "xpi_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-mozlinguas-v2
  '(("mozlinguas-v2_src_compile" "mozlinguas-v2_src_install"
     "mozlinguas-v2_src_unpack" "mozlinguas_mozconfig"
     "mozlinguas_src_compile" "mozlinguas_src_install" "mozlinguas_src_unpack"
     "mozlinguas_xpistage_langpacks")
    font-lock-type-face))

(defvar ebuild-mode-keywords-multibuild
  '(("multibuild_copy_sources" "multibuild_for_best_variant"
     "multibuild_foreach_variant" "multibuild_merge_root"
     "multibuild_parallel_foreach_variant" "run_in_build_dir")
    font-lock-type-face))

(defvar ebuild-mode-keywords-multilib
  '(("get_abi_CFLAGS" "get_abi_CHOST" "get_abi_CTARGET" "get_abi_FAKE_TARGETS"
     "get_abi_LDFLAGS" "get_abi_LIBDIR" "get_all_abis" "get_all_libdirs"
     "get_exeext" "get_install_abis" "get_libname" "get_modname"
     "has_multilib_profile" "is_final_abi" "multilib_env"
     "multilib_toolchain_setup" "number_abis")
    font-lock-type-face))

(defvar ebuild-mode-keywords-multilib-build
  '(("multilib_build_binaries" "multilib_check_headers"
     "multilib_copy_sources" "multilib_for_best_abi" "multilib_foreach_abi"
     "multilib_get_enabled_abi_pairs" "multilib_get_enabled_abis"
     "multilib_install_wrappers" "multilib_is_native_abi"
     "multilib_native_enable" "multilib_native_use_enable"
     "multilib_native_use_with" "multilib_native_usex" "multilib_native_with"
     "multilib_parallel_foreach_abi" "multilib_prepare_wrappers")
    font-lock-type-face))

(defvar ebuild-mode-keywords-multilib-minimal
  '(("multilib-minimal_src_compile" "multilib-minimal_src_configure"
     "multilib-minimal_src_install" "multilib-minimal_src_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-multiprocessing
  '(("get_nproc" "makeopts_jobs" "makeopts_loadavg")
    font-lock-type-face))

(defvar ebuild-mode-keywords-myspell-r2
  '(("myspell-r2_src_install" "myspell-r2_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-netsurf
  '(("netsurf_define_makeconf")
    font-lock-type-face))

(defvar ebuild-mode-keywords-ninja-utils
  '(("eninja")
    font-lock-type-face))

(defvar ebuild-mode-keywords-nsplugins
  '(("inst_plugin" "pkg_mv_plugins" "share_plugins_dir" "src_mv_plugins")
    font-lock-type-face))

(defvar ebuild-mode-keywords-nvidia-driver
  '(("nvidia-driver_check" "nvidia-driver_check_gpu"
     "nvidia-driver_check_kernel" "nvidia-driver_get_gpu"
     "nvidia-driver_get_mask")
    font-lock-type-face))

(defvar ebuild-mode-keywords-oasis
  '(("oasis_src_compile" "oasis_src_configure" "oasis_src_install"
     "oasis_src_test" "oasis_use_enable")
    font-lock-type-face))

(defvar ebuild-mode-keywords-office-ext-r1
  '(("office-ext-r1_src_install" "office-ext-r1_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-opam
  '(("opam-install" "opam_src_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-openib
  '(("block_other_ofed_versions" "openib_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-optfeature
  '(("optfeature")
    font-lock-type-face))

(defvar ebuild-mode-keywords-out-of-source
  '(("out-of-source_src_compile" "out-of-source_src_configure"
     "out-of-source_src_install" "out-of-source_src_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-pam
  '(("cleanpamd" "dopamd" "dopammod" "dopamsecurity" "getpam_mod_dir"
     "newpamd" "newpammod" "newpamsecurity" "pamd_mimic" "pamd_mimic_system"
     "pammod_hide_symbols")
    font-lock-type-face))

(defvar ebuild-mode-keywords-pax-utils
  '(("host-is-pax" "list-paxables" "pax-mark")
    font-lock-type-face))

(defvar ebuild-mode-keywords-perl-functions
  '(("perl_check_env" "perl_delete_emptybsdir" "perl_delete_localpod"
     "perl_delete_module_manpages" "perl_delete_packlist" "perl_doexamples"
     "perl_domodule" "perl_fix_osx_extra" "perl_fix_packlist"
     "perl_get_module_version" "perl_get_raw_vendorlib" "perl_get_vendorlib"
     "perl_has_module" "perl_has_module_version" "perl_link_duallife_scripts"
     "perl_remove_temppath" "perl_rm_files" "perl_set_version")
    font-lock-type-face))

(defvar ebuild-mode-keywords-perl-module
  '(("perl-module_pkg_postinst" "perl-module_pkg_postrm"
     "perl-module_src_compile" "perl-module_src_configure"
     "perl-module_src_install" "perl-module_src_prepare"
     "perl-module_src_test" "perl-module_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-php-ext-pecl-r3
  '(("php-ext-pecl-r3_src_install" "php-ext-pecl-r3_src_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-php-ext-source-r3
  '(("php-ext-source-r3_addtoinifiles" "php-ext-source-r3_createinifiles"
     "php-ext-source-r3_phpize" "php-ext-source-r3_src_compile"
     "php-ext-source-r3_src_configure" "php-ext-source-r3_src_install"
     "php-ext-source-r3_src_prepare" "php-ext-source-r3_src_test"
     "php_get_slots" "php_init_slot_env")
    font-lock-type-face))

(defvar ebuild-mode-keywords-php-pear-r2
  '(("php-pear-r2_install_packagexml" "php-pear-r2_pkg_postinst"
     "php-pear-r2_pkg_postrm" "php-pear-r2_src_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-portability
  '(("dlopen_lib" "get_bmake" "get_mounts" "is-login-disabled" "seq"
     "treecopy")
    font-lock-type-face))

(defvar ebuild-mode-keywords-postgres
  '(("postgres_check_slot" "postgres_new_user" "postgres_pkg_setup")
    font-lock-type-face))

(defvar ebuild-mode-keywords-postgres-multi
  '(("postgres-multi_forbest" "postgres-multi_foreach"
     "postgres-multi_pkg_setup" "postgres-multi_src_compile"
     "postgres-multi_src_install" "postgres-multi_src_prepare"
     "postgres-multi_src_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-prefix
  '(("eprefixify" "hprefixify" "prefixify_ro")
    font-lock-type-face))

(defvar ebuild-mode-keywords-preserve-libs
  '(("preserve_old_lib" "preserve_old_lib_notify")
    font-lock-type-face))

(defvar ebuild-mode-keywords-python-any-r1
  '(("python-any-r1_pkg_setup" "python_gen_any_dep" "python_setup")
    font-lock-type-face))

(defvar ebuild-mode-keywords-python-r1
  '(("python_copy_sources" "python_foreach_impl" "python_gen_any_dep"
     "python_gen_cond_dep" "python_gen_impl_dep" "python_gen_usedep"
     "python_gen_useflags" "python_replicate_script" "python_setup")
    font-lock-type-face))

(defvar ebuild-mode-keywords-python-single-r1
  '(("python-single-r1_pkg_setup" "python_gen_cond_dep" "python_gen_impl_dep"
     "python_gen_useflags" "python_setup")
    font-lock-type-face))

(defvar ebuild-mode-keywords-python-utils-r1
  '(("build_sphinx" "epytest" "python_doexe" "python_doheader"
     "python_domodule" "python_doscript" "python_export_utf8_locale"
     "python_fix_shebang" "python_get_CFLAGS" "python_get_LIBS"
     "python_get_PYTHON_CONFIG" "python_get_includedir"
     "python_get_library_path" "python_get_scriptdir" "python_get_sitedir"
     "python_is_installed" "python_is_python3" "python_moduleinto"
     "python_newexe" "python_newscript" "python_optimize" "python_scriptinto"
     "python_wrapper_setup")
    font-lock-type-face))

(defvar ebuild-mode-keywords-qmail
  '(("dospp" "dosupervise" "genqmail_src_unpack" "is_prime" "primes"
     "qmail_base_install" "qmail_config_fast" "qmail_config_install"
     "qmail_config_notice" "qmail_maildir_install" "qmail_man_install"
     "qmail_queue_setup" "qmail_rootmail_fixup" "qmail_sendmail_install"
     "qmail_set_cc" "qmail_spp_install" "qmail_spp_src_compile"
     "qmail_spp_src_unpack" "qmail_src_compile" "qmail_src_install"
     "qmail_src_postunpack" "qmail_ssl_generate" "qmail_ssl_install"
     "qmail_supervise_config_notice" "qmail_supervise_install"
     "qmail_supervise_install_one" "qmail_tcprules_build"
     "qmail_tcprules_config" "qmail_tcprules_fixup" "qmail_tcprules_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-qmake-utils
  '(("eqmake5" "qt5_get_bindir" "qt5_get_headerdir" "qt5_get_libdir"
     "qt5_get_mkspecsdir" "qt5_get_plugindir")
    font-lock-type-face))

(defvar ebuild-mode-keywords-qt5-build
  '(("qt5-build_pkg_postinst" "qt5-build_pkg_postrm" "qt5-build_src_compile"
     "qt5-build_src_configure" "qt5-build_src_install" "qt5-build_src_prepare"
     "qt5-build_src_test" "qt5-build_src_unpack" "qt_use"
     "qt_use_compile_test" "qt_use_disable_config" "qt_use_disable_mod")
    font-lock-type-face))

(defvar ebuild-mode-keywords-readme.gentoo
  '(("readme.gentoo_create_doc" "readme.gentoo_pkg_postinst"
     "readme.gentoo_print_elog" "readme.gentoo_src_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-readme.gentoo-r1
  '(("readme.gentoo_create_doc" "readme.gentoo_print_elog")
    font-lock-type-face))

(defvar ebuild-mode-keywords-rebar
  '(("erebar" "get_erl_libs" "rebar_disable_coverage" "rebar_fix_include_path"
     "rebar_remove_deps" "rebar_set_vsn" "rebar_src_compile"
     "rebar_src_configure" "rebar_src_install" "rebar_src_prepare"
     "rebar_src_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-ros-catkin
  '(("ros-catkin_src_compile" "ros-catkin_src_configure"
     "ros-catkin_src_install" "ros-catkin_src_prepare" "ros-catkin_src_test")
    font-lock-type-face))

(defvar ebuild-mode-keywords-rpm
  '(("rpm_spec_epatch" "rpm_src_unpack" "rpm_unpack" "srcrpm_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-ruby-fakegem
  '(("all_fakegem_compile" "all_fakegem_install" "all_ruby_compile"
     "all_ruby_install" "all_ruby_unpack" "each_fakegem_compile"
     "each_fakegem_configure" "each_fakegem_install" "each_fakegem_test"
     "each_ruby_compile" "each_ruby_configure" "each_ruby_install"
     "each_ruby_test" "ruby_fakegem_binwrapper" "ruby_fakegem_doins"
     "ruby_fakegem_gemsdir" "ruby_fakegem_gemspec_gemspec"
     "ruby_fakegem_genspec" "ruby_fakegem_install_gemspec"
     "ruby_fakegem_metadata_gemspec" "ruby_fakegem_newins")
    font-lock-type-face))

(defvar ebuild-mode-keywords-ruby-ng
  '(("doruby" "ruby-ng_cucumber" "ruby-ng_pkg_setup" "ruby-ng_rspec"
     "ruby-ng_src_compile" "ruby-ng_src_configure" "ruby-ng_src_install"
     "ruby-ng_src_prepare" "ruby-ng_src_test" "ruby-ng_src_unpack"
     "ruby-ng_testrb-2" "ruby_add_bdepend" "ruby_add_depend"
     "ruby_add_rdepend" "ruby_get_hdrdir" "ruby_get_implementation"
     "ruby_get_libruby" "ruby_get_use_implementations" "ruby_get_use_targets"
     "ruby_get_version" "ruby_implementation_command"
     "ruby_implementation_depend" "ruby_implementations_depend"
     "ruby_rbconfig_value" "ruby_samelib")
    font-lock-type-face))

(defvar ebuild-mode-keywords-ruby-ng-gnome2
  '(("all_ruby_install" "all_ruby_prepare" "each_ruby_compile"
     "each_ruby_configure" "each_ruby_install" "each_ruby_test"
     "ruby-ng-gnome2_all_ruby_prepare")
    font-lock-type-face))

(defvar ebuild-mode-keywords-rust-toolchain
  '(("rust_abi" "rust_all_abis" "rust_all_arch_uris" "rust_arch_uri")
    font-lock-type-face))

(defvar ebuild-mode-keywords-s6
  '(("s6_get_servicedir" "s6_install_service" "s6_service_down"
     "s6_service_nosetsid")
    font-lock-type-face))

(defvar ebuild-mode-keywords-savedconfig
  '(("restore_config" "save_config" "savedconfig_pkg_postinst")
    font-lock-type-face))

(defvar ebuild-mode-keywords-scons-utils
  '(("escons" "use_scons")
    font-lock-type-face))

(defvar ebuild-mode-keywords-selinux-policy-2
  '(("selinux-policy-2_pkg_postinst" "selinux-policy-2_pkg_postrm"
     "selinux-policy-2_src_compile" "selinux-policy-2_src_install"
     "selinux-policy-2_src_prepare" "selinux-policy-2_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-sgml-catalog-r1
  '(("sgml-catalog-r1_pkg_postinst" "sgml-catalog-r1_pkg_postrm"
     "sgml-catalog-r1_update_catalog" "sgml-catalog-r1_update_env")
    font-lock-type-face))

(defvar ebuild-mode-keywords-ssl-cert
  '(("gen_cnf" "gen_crt" "gen_csr" "gen_key" "gen_pem" "get_base"
     "install_cert")
    font-lock-type-face))

(defvar ebuild-mode-keywords-stardict
  '(("stardict_src_compile" "stardict_src_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-subversion
  '(("subversion__get_peg_revision" "subversion__get_repository_uri"
     "subversion__get_wc_path" "subversion__svn_info" "subversion_bootstrap"
     "subversion_fetch" "subversion_pkg_preinst" "subversion_src_prepare"
     "subversion_src_unpack" "subversion_wc_info")
    font-lock-type-face))

(defvar ebuild-mode-keywords-sword-module
  '(("sword-module_src_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-systemd
  '(("systemd_dotmpfilesd" "systemd_dounit" "systemd_douserunit"
     "systemd_enable_ntpunit" "systemd_enable_service"
     "systemd_get_systemgeneratordir" "systemd_get_systemunitdir"
     "systemd_get_unitdir" "systemd_get_userunitdir" "systemd_get_utildir"
     "systemd_install_serviced" "systemd_is_booted" "systemd_newtmpfilesd"
     "systemd_newunit" "systemd_newuserunit" "systemd_reenable"
     "systemd_tmpfiles_create" "systemd_update_catalog" "systemd_with_unitdir"
     "systemd_with_utildir")
    font-lock-type-face))

(defvar ebuild-mode-keywords-texlive-common
  '(("dobin_texmf_scripts" "efmtutil-sys" "etexlinks" "etexmf-update"
     "texlive-common_do_symlinks" "texlive-common_handle_config_files"
     "texlive-common_is_file_present_in_texmf")
    font-lock-type-face))

(defvar ebuild-mode-keywords-texlive-module
  '(("texlive-module_add_format" "texlive-module_make_language_dat_lines"
     "texlive-module_make_language_def_lines"
     "texlive-module_make_language_lua_lines" "texlive-module_pkg_postinst"
     "texlive-module_pkg_postrm" "texlive-module_src_compile"
     "texlive-module_src_install" "texlive-module_src_unpack"
     "texlive-module_synonyms_to_language_lua_line")
    font-lock-type-face))

(defvar ebuild-mode-keywords-tmpfiles
  '(("dotmpfiles" "newtmpfiles" "tmpfiles_process")
    font-lock-type-face))

(defvar ebuild-mode-keywords-toolchain
  '(("XGCC" "copy_minispecs_gcc_specs" "create_gcc_env_entry"
     "create_revdep_rebuild_entry" "do_gcc_CYGWINPORTS_patches"
     "do_gcc_PIE_patches" "do_gcc_config" "do_gcc_gentoo_patches"
     "downgrade_arch_flags" "fix_libtool_libdir_paths" "gcc-abi-map"
     "gcc-lang-supported" "gcc-multilib-configure" "gcc_do_filter_flags"
     "gcc_do_make" "gcc_movelibs" "gcc_slot_java" "gcc_version_patch"
     "gentoo_urls" "get_gcc_src_uri" "get_make_var" "hardened_gcc_is_stable"
     "hardened_gcc_works" "is_ada" "is_crosscompile" "is_cxx" "is_d" "is_f77"
     "is_f95" "is_fortran" "is_gcj" "is_go" "is_jit" "is_multilib" "is_objc"
     "is_objcxx" "make_gcc_hard" "setup_minispecs_gcc_build_specs"
     "setup_multilib_osdirnames" "should_we_gcc_config" "tc_apply_patches"
     "tc_has_feature" "tc_is_live" "tc_supports_dostrip"
     "tc_version_is_at_least" "tc_version_is_between" "toolchain_death_notice"
     "toolchain_pkg_postinst" "toolchain_pkg_postrm" "toolchain_pkg_pretend"
     "toolchain_pkg_setup" "toolchain_src_compile" "toolchain_src_configure"
     "toolchain_src_install" "toolchain_src_prepare" "toolchain_src_test"
     "toolchain_src_unpack" "want_minispecs" "want_pie")
    font-lock-type-face))

(defvar ebuild-mode-keywords-toolchain-autoconf
  '(("slot_info_pages" "toolchain-autoconf_src_configure"
     "toolchain-autoconf_src_install" "toolchain-autoconf_src_prepare")
    font-lock-type-face))

(defvar ebuild-mode-keywords-toolchain-funcs
  '(("clang-fullversion" "clang-major-version" "clang-micro-version"
     "clang-minor-version" "clang-version" "econf_build" "gcc-fullversion"
     "gcc-major-version" "gcc-micro-version" "gcc-minor-version"
     "gcc-specs-directive" "gcc-specs-nostrict" "gcc-specs-now"
     "gcc-specs-pie" "gcc-specs-relro" "gcc-specs-ssp" "gcc-specs-ssp-to-all"
     "gcc-specs-stack-check" "gcc-version" "gen_usr_ldscript" "tc-arch"
     "tc-arch-kernel" "tc-check-openmp" "tc-cpp-is-true"
     "tc-detect-is-softfloat" "tc-enables-pie" "tc-enables-ssp"
     "tc-enables-ssp-all" "tc-enables-ssp-strong" "tc-endian" "tc-export"
     "tc-export_build_env" "tc-get-compiler-type" "tc-getAR" "tc-getAS"
     "tc-getBUILD_AR" "tc-getBUILD_AS" "tc-getBUILD_CC" "tc-getBUILD_CPP"
     "tc-getBUILD_CXX" "tc-getBUILD_LD" "tc-getBUILD_NM" "tc-getBUILD_OBJCOPY"
     "tc-getBUILD_PKG_CONFIG" "tc-getBUILD_PROG" "tc-getBUILD_RANLIB"
     "tc-getBUILD_READELF" "tc-getBUILD_STRINGS" "tc-getBUILD_STRIP"
     "tc-getCC" "tc-getCPP" "tc-getCXX" "tc-getDLLWRAP" "tc-getF77" "tc-getFC"
     "tc-getGCJ" "tc-getGO" "tc-getLD" "tc-getNM" "tc-getOBJCOPY"
     "tc-getOBJDUMP" "tc-getPKG_CONFIG" "tc-getPROG" "tc-getRANLIB" "tc-getRC"
     "tc-getREADELF" "tc-getSTRINGS" "tc-getSTRIP" "tc-getTARGET_CPP"
     "tc-has-openmp" "tc-has-tls" "tc-is-clang" "tc-is-cross-compiler"
     "tc-is-gcc" "tc-is-softfloat" "tc-is-static-only" "tc-ld-disable-gold"
     "tc-ld-force-bfd" "tc-ld-is-gold" "tc-ld-is-lld" "tc-ninja_magic_to_arch"
     "tc-stack-grows-down" "tc-tuple-is-softfloat")
    font-lock-type-face))

(defvar ebuild-mode-keywords-toolchain-glibc
  '(("alt_build_headers" "alt_headers" "alt_libdir" "alt_prefix"
     "alt_usrlibdir" "builddir" "check_devpts" "check_nptl_support"
     "dump_toolchain_settings" "eend_KV" "foreach_abi" "get_kheader_version"
     "glibc_banner" "glibc_compile_test" "glibc_do_configure" "glibc_run_test"
     "glibc_sanity_check" "glibc_src_test" "just_headers" "nonfatal"
     "setup_env" "setup_flags" "setup_target_flags" "tc_glibc_KV_major"
     "tc_glibc_KV_micro" "tc_glibc_KV_minor" "tc_glibc_KV_to_int"
     "tc_glibc_get_KV" "tc_glibc_int_to_KV" "toolchain-glibc_do_src_compile"
     "toolchain-glibc_do_src_configure" "toolchain-glibc_do_src_install"
     "toolchain-glibc_do_src_test" "toolchain-glibc_do_src_unpack"
     "toolchain-glibc_headers_configure" "toolchain-glibc_headers_install"
     "toolchain-glibc_pkg_postinst" "toolchain-glibc_pkg_preinst"
     "toolchain-glibc_pkg_pretend" "toolchain-glibc_pkg_setup"
     "toolchain-glibc_src_compile" "toolchain-glibc_src_configure"
     "toolchain-glibc_src_install" "toolchain-glibc_src_prepare"
     "toolchain-glibc_src_test" "toolchain-glibc_src_unpack" "unpack_pkg"
     "use_multiarch" "want__thread" "want_linuxthreads" "want_nptl"
     "want_tls")
    font-lock-type-face))

(defvar ebuild-mode-keywords-udev
  '(("get_udevdir" "udev_dorules" "udev_get_udevdir" "udev_newrules"
     "udev_reload")
    font-lock-type-face))

(defvar ebuild-mode-keywords-unpacker
  '(("find_unpackable_file" "unpack_banner" "unpack_cpio" "unpack_deb"
     "unpack_makeself" "unpack_pdv" "unpack_zip" "unpacker"
     "unpacker_src_unpack" "unpacker_src_uri_depends")
    font-lock-type-face))

(defvar ebuild-mode-keywords-user
  '(("enewgroup" "enewuser" "esetcomment" "esetgroups" "esethome" "esetshell")
    font-lock-type-face))

(defvar ebuild-mode-keywords-user-info
  '(("egetcomment" "egetent" "egetgroupname" "egetgroups" "egethome"
     "egetshell" "egetusername")
    font-lock-type-face))

(defvar ebuild-mode-keywords-usr-ldscript
  '(("gen_usr_ldscript")
    font-lock-type-face))

(defvar ebuild-mode-keywords-vala
  '(("vala_api_versions" "vala_best_api_version" "vala_depend"
     "vala_src_prepare")
    font-lock-type-face))

(defvar ebuild-mode-keywords-vcs-clean
  '(("ecvs_clean" "egit_clean" "esvn_clean")
    font-lock-type-face))

(defvar ebuild-mode-keywords-vcs-snapshot
  '(("vcs-snapshot_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-vdr-plugin-2
  '(("fix_vdr_libsi_include" "has_vdr" "vdr-plugin-2_pkg_config"
     "vdr-plugin-2_pkg_postinst" "vdr-plugin-2_pkg_postrm"
     "vdr-plugin-2_pkg_setup" "vdr-plugin-2_print_enable_command"
     "vdr-plugin-2_src_compile" "vdr-plugin-2_src_install"
     "vdr-plugin-2_src_prepare" "vdr-plugin-2_src_unpack"
     "vdr-plugin-2_src_util" "vdr_create_header_checksum_file"
     "vdr_create_plugindb_file" "vdr_detect_po_dir" "vdr_gettext_missing"
     "vdr_i18n" "vdr_linguas_support" "vdr_patchmakefile"
     "vdr_remove_i18n_include")
    font-lock-type-face))

(defvar ebuild-mode-keywords-verify-sig
  '(("verify-sig_src_unpack" "verify-sig_verify_detached"
     "verify-sig_verify_message" "verify-sig_verify_signed_checksums")
    font-lock-type-face))

(defvar ebuild-mode-keywords-versionator
  '(("delete_all_version_separators" "delete_version_separator"
     "get_after_major_version" "get_all_version_components"
     "get_last_version_component_index" "get_major_version"
     "get_version_component_count" "get_version_component_range"
     "get_version_components" "replace_all_version_separators"
     "replace_version_separator" "version_compare" "version_format_string"
     "version_is_at_least" "version_sort")
    font-lock-type-face))

(defvar ebuild-mode-keywords-vim-doc
  '(("update_vim_helptags")
    font-lock-type-face))

(defvar ebuild-mode-keywords-vim-plugin
  '(("display_vim_plugin_help" "update_vim_afterscripts"
     "vim-plugin_pkg_postinst" "vim-plugin_pkg_postrm"
     "vim-plugin_src_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-vim-spell
  '(("vim-spell_pkg_postinst" "vim-spell_src_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-virtualx
  '(("Xeconf" "Xemake" "Xmake" "virtualmake" "virtx")
    font-lock-type-face))

(defvar ebuild-mode-keywords-waf-utils
  '(("waf-utils_src_compile" "waf-utils_src_configure"
     "waf-utils_src_install")
    font-lock-type-face))

(defvar ebuild-mode-keywords-webapp
  '(("need_httpd" "need_httpd_cgi" "need_httpd_fastcgi"
     "webapp_check_installedat" "webapp_checkfileexists" "webapp_configfile"
     "webapp_getinstalltype" "webapp_hook_script" "webapp_pkg_postinst"
     "webapp_pkg_prerm" "webapp_pkg_setup" "webapp_postinst_txt"
     "webapp_postupgrade_txt" "webapp_read_config" "webapp_server_configfile"
     "webapp_serverowned" "webapp_sqlscript" "webapp_src_install"
     "webapp_src_preinst" "webapp_strip_appdir" "webapp_strip_cwd"
     "webapp_strip_d")
    font-lock-type-face))

(defvar ebuild-mode-keywords-wrapper
  '(("make_wrapper")
    font-lock-type-face))

(defvar ebuild-mode-keywords-wxwidgets
  '(("need-wxwidgets" "setup-wxwidgets")
    font-lock-type-face))

(defvar ebuild-mode-keywords-xdg
  '(("xdg_pkg_postinst" "xdg_pkg_postrm" "xdg_pkg_preinst" "xdg_src_prepare")
    font-lock-type-face))

(defvar ebuild-mode-keywords-xdg-utils
  '(("xdg_desktop_database_update" "xdg_environment_reset"
     "xdg_icon_cache_update" "xdg_mimeinfo_database_update")
    font-lock-type-face))

(defvar ebuild-mode-keywords-xemacs-packages
  '(("xemacs-packages_src_install" "xemacs-packages_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-xorg-2
  '(("create_fonts_dir" "create_fonts_scale" "remove_font_metadata"
     "xorg-2_flags_setup" "xorg-2_font_configure" "xorg-2_patch_source"
     "xorg-2_pkg_postinst" "xorg-2_pkg_postrm" "xorg-2_pkg_setup"
     "xorg-2_reconf_source" "xorg-2_src_compile" "xorg-2_src_configure"
     "xorg-2_src_install" "xorg-2_src_prepare" "xorg-2_src_unpack")
    font-lock-type-face))

(defvar ebuild-mode-keywords-xorg-3
  '(("create_fonts_dir" "create_fonts_scale" "multilib_src_compile"
     "multilib_src_configure" "multilib_src_install" "remove_font_metadata"
     "xorg-3_flags_setup" "xorg-3_font_configure" "xorg-3_pkg_postinst"
     "xorg-3_pkg_postrm" "xorg-3_pkg_setup" "xorg-3_reconf_source"
     "xorg-3_src_compile" "xorg-3_src_configure" "xorg-3_src_install"
     "xorg-3_src_prepare" "xorg-3_src_unpack")
    font-lock-type-face))

;; @@KEYWORDS-END@@

;; Local Variables:
;; coding: utf-8
;; fill-column: 78
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:

;;; ebuild-mode-keywords.el ends here
