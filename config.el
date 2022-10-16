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
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))


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


(map! :map evil-window-map
      [left]  #'evil-window-left
      [right] #'evil-window-right
      [up] #'evil-window-up
      [down] #'evil-window-down)
;; Isabelle setup
(use-package! isar-mode
  :mode "\\.thy\\'"
  :config
  ;; (add-hook 'isar-mode-hook 'turn-on-highlight-indentation-mode)
  (add-hook 'isar-mode-hook 'flycheck-mode)
  (add-hook 'isar-mode-hook 'company-mode)
  (add-hook 'isar-mode-hook
            (lambda ()
              (set (make-local-variable 'company-backends)
                   '((company-dabbrev-code company-yasnippet)))))
  (add-hook 'isar-mode-hook
            (lambda ()
              (set (make-local-variable 'indent-tabs-mode) nil)))
  (add-hook 'isar-mode-hook
            (lambda ()
              (yas-minor-mode)))
  )

(use-package! lsp-isar-parse-args
  :custom
  (lsp-isar-parse-args-nollvm nil))

(use-package! lsp-isar
  :commands lsp-isar-define-client-and-start
  :custom
  (lsp-isar-output-use-async t)
  (lsp-isar-output-time-before-printing-goal nil)
  (lsp-isar-experimental t)
  (lsp-isar-split-pattern 'lsp-isar-split-pattern-two-columns)
  (lsp-isar-decorations-delayed-printing t)
  :init
  (add-hook 'lsp-isar-init-hook 'lsp-isar-open-output-and-progress-right-spacemacs)
  (add-hook 'isar-mode-hook #'lsp-isar-define-client-and-start)

  (push (concat "~/Programme/isabelle-emacs/src/Tools/emacs-lsp/yasnippet")
        yas-snippet-dirs)
  (setq lsp-isar-path-to-isabelle "~/Programme/isabelle-emacs")
  )  ; looks for ~/.doom.d/my/package/my-package.el


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

(add-hook 'lsp-mode-hook 'lsp-semantic-tokens-mode)


;; Custom keybindings
(map! :leader :map 'isar-mode-map :localleader
      (:prefix ("s" . "Sledgehammer...")
      :desc "Open interface"
      "s" #'lsp-isar-sledgehammer-interface))
 (map! :leader :map 'isar-mode-map :localleader
      (:prefix ("s" . "Sledgehammer...")
      :desc "Insert with interface"
      "S"
      #'lsp-isar-insert-sledgehammer-and-call))
 (map! :leader :map 'isar-mode-map :localleader
      (:prefix ("s" . "Sledgehammer...")
      :desc "Insert sledgehammer"
      "i"
      #'lsp-isar-insert-sledgehammer-and-call))

(map! :leader :map 'isar-mode-map :localleader
      (:prefix ("t" . "Try0...")
        :desc "Insert try0"
        "t"
        #'lsp-isar-insert-try0))
(map! :leader :map 'isar-mode-map :localleader
      (:prefix ("t" . "Try0...")
        :desc "Insert proof"
        "p"
        #'lsp-isar-insert-try0-proof))
(map! :leader :map 'isar-mode-map :localleader :desc "Insert auto"
      "a" #'lsp-isar-insert-auto)
(map! :leader :map 'isar-mode-map :localleader :desc "Insert simp"
      "b" #'lsp-isar-insert-simp)
(map! :leader :map 'isar-mode-map :localleader :desc "Insert meson"
      "e" #'lsp-isar-insert-meson)
(map! :leader :map 'isar-mode-map :localleader :desc "Insert fastforce"
      "f" #'lsp-isar-insert-fastforce)
(map! :leader :map 'isar-mode-map :localleader :desc "Insert algebra"
      "g" #'lsp-isar-insert-algebra)
(map! :leader :map 'isar-mode-map :localleader :desc "Insert linarith"
      "l" #'lsp-isar-insert-linarith)
(map! :leader :map 'isar-mode-map :localleader :desc "Insert force"
      "F" #'lsp-isar-insert-force)
(map! :leader :map 'isar-mode-map :localleader :desc "Insert fast"
      "o" #'lsp-isar-insert-fast)
(map! :leader :map 'isar-mode-map :localleader :desc "Insert presburger"
      "p" #'lsp-isar-insert-presburger)
(map! :leader :map 'isar-mode-map :localleader :desc "Insert argo"
      "r" #'lsp-isar-insert-argo)
(map! :leader :map 'isar-mode-map :localleader :desc "Insert satx"
      "x" #'lsp-isar-insert-satx)
(map! :leader :map 'isar-mode-map :localleader :desc "Insert proof outline"
      "P" #'lsp-isar-insert-proof-outline)


(map! :leader :map 'treemacs-mode-map :localleader :desc "Switch workspace"
      "s" #'treemacs-switch-workspace)
(map! :leader :map 'treemacs-mode-map :localleader :desc "Edit workspaces"
      "e" #'treemacs-edit-workspaces)
(map! :leader :map 'treemacs-mode-map :localleader :desc "Add project"
      "a" #'treemacs-add-project-to-workspace)
(map! :leader :map 'treemacs-mode-map :localleader :desc "Remove project"
      "R" #'treemacs-remove-project-from-workspace)
(map! :leader :map 'treemacs-mode-map :localleader :desc "Rename project"
      "r" #'treemacs-rename-project)
