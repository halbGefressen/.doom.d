;; -----Set this variable to your isabelle-emacs path-----
(setq local-isabelle-path "~/Programme/isabelle-emacs")
;; -------------------------------------------------------

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


;; Keybindings for local leader
(load! "keybindings.el")
