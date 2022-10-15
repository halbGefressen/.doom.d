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
