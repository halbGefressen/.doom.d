;; -----Set this variable to your isabelle-emacs path-----
(setq local-isabelle-path "~/Programme/isabelle-emacs")
;; -------------------------------------------------------


;; export CVC5_SOLVER=$HOME/Programme/isabelle-emacs/cvc5-1.0.2/x86_64-linux/cvc5
;; export CVC5_VERSION="1.0.2"
;; export E_HOME=/home/christian/Programme/eprover/PROVER
;; export E_VERSION="3.0"
;; export ISABELLE_VERIT=$HOME/Programme/isabelle-emacs/verit-2021.06.2-rmx/x86_64-linux/veriT
;; export VERIT_VERSION="2021.06.2-RMX"

(setenv "CVC5_SOLVER" (concat
        (getenv "HOME")
        "/Programme/isabelle-emacs/cvc5-1.0.2/x86_64-linux/cvc5"))
(setenv "CVC5_VERSION" "1.0.2")
(setenv "E_HOME" (concat (getenv "HOME") "/Programme/eprover/PROVER"))
(setenv "E_VERSION" "3.0")
;; (setenv "ISABELLE_VERIT" (concat
;;      (getenv "HOME")
;;      "/Programme/isabelle-emacs/verit-2021.06.2-rmx/x86_64-linux/veriT"))

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
  ;; fix unicode completion
  (add-hook 'isar-mode-hook
            (lambda ()
              (unicode-tokens-mode) (unicode-tokens-mode)))
  (add-hook 'isar-mode-hook #'display-line-numbers-mode)
  )

(use-package! lsp-isar-parse-args
  :custom
  (lsp-isar-parse-args-nollvm nil)
  )

(defun lsp-isar-open-output-and-progress-isabelle ()
  (interactive)
  (split-window-below)
  (other-window 1)
  (switch-to-buffer "*lsp-isar-state*")
  (text-scale-set -1)
  (lsp-isar-toggle-window-dedicated)
  (evil-window-set-height 12)
  (split-window-right)
  (other-window 1)
  (evil-window-set-width 75)
  (switch-to-buffer "*lsp-isar-output*")
  (text-scale-set -1)
  (lsp-isar-toggle-window-dedicated)
  (other-window -2)
  (split-window-right)
  (other-window 1)
  (switch-to-buffer "*lsp-isar-progress*")
  (evil-window-set-width 30)
  (text-scale-set -3)
  (lsp-isar-toggle-window-dedicated)
  (other-window -1)
)

(use-package! lsp-isar
  :commands lsp-isar-define-client-and-start
  :custom
  (lsp-isar-output-use-async t)
  (lsp-isar-output-time-before-printing-goal nil)
  (lsp-isar-experimental t)
  (lsp-isar-split-pattern 'lsp-isar-split-pattern-two-columns)
  (lsp-isar-decorations-delayed-printing t)
  :init
  (add-hook 'lsp-isar-init-hook 'lsp-isar-open-output-and-progress-isabelle)
  (add-hook 'isar-mode-hook #'lsp-isar-define-client-and-start)

  (push (concat local-isabelle-path "/src/Tools/emacs-lsp/yasnippet")
        yas-snippet-dirs)
  (setq lsp-isar-path-to-isabelle local-isabelle-path)
  )  ; looks for ~/.doom.d/my/package/my-package.el

;; https://github.com/m-fleury/isabelle-release/issues/21
(defun ~/evil-motion-range--wrapper (fn &rest args)
  "Like `evil-motion-range', but override field-beginning for performance.
     See URL `https://github.com/ProofGeneral/PG/issues/427'."
          (cl-letf (((symbol-function 'field-beginning)
                                  (lambda (&rest args) 1)))
                       (apply fn args)))
            (advice-add #'evil-motion-range :around #'~/evil-motion-range--wrapper)



(setq lsp-isabelle-options (append lsp-isabelle-options (list "-d" "/home/christian/Programme/PSL" "-l" "Smart_Isabelle")))
;; Keybindings for local leader
(load! "keybindings.el")
