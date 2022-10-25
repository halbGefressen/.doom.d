;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Christian Zimmerer"
      user-mail-address "chzi@pm.me")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Noto Sans Mono" :size 15 :weight 'semi-light)
      doom-variable-pitch-font
      (font-spec :family "Noto Sans" :size 15)
      )

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; This starts Emacs maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys

;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(setq display-time-default-load-average 'nil)
(display-time-mode 1)

;; Keybind for maximizing
(map! :leader (:prefix ("t" . "toggle")
        :desc "Maximize window" "M" #'toggle-frame-maximized))

;; Navigation with SPC w arrowkeys
(map! :map evil-window-map
      [left]  #'evil-window-left
      [right] #'evil-window-right
      [up] #'evil-window-up
      [down] #'evil-window-down)

;; Isabelle configuration
(load! "isabelle-settings/config.el")


;; Discord rich presence
(setq elcord-refresh-rate 5)
(setq elcord-use-major-mode-as-main-icon :true)
(setq elcord-editor-icon "emacs_material_icon")
(setq elcord-show-small-icon :false)
;; (elcord-mode)

;; Haskell language server
(setq lsp-haskell-server-path "~/.ghcup/bin/haskell-language-server-wrapper")

;; LSP+clangd
(setq lsp-clients-clangd-args '("-j=3"
				"--background-index"
				"--clang-tidy"
				"--completion-style=detailed"
				"--header-insertion=never"
				"--header-insertion-decorators=0"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

;; Semantic highlighting
(add-hook 'lsp-mode-hook 'lsp-semantic-tokens-mode)


(map! :leader :map 'treemacs-mode-map :localleader
        :desc "Switch workspace" "s" #'treemacs-switch-workspace
        :desc "Edit workspaces"  "e" #'treemacs-edit-workspaces
        :desc "Add project"      "a" #'treemacs-add-project-to-workspace
        :desc "Remove project"   "R" #'treemacs-remove-project-from-workspace
        :desc "Rename project"   "r" #'treemacs-rename-project)
