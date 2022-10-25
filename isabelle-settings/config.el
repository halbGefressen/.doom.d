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
  (add-hook 'lsp-isar-init-hook 'lsp-isar-open-output-and-progress-right-two-columns)
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
(map! :leader :map 'isar-mode-map :localleader
      (:prefix ("t" . "Try0...")
                :desc "Insert try0"           "t" #'lsp-isar-insert-try0
                :desc "Insert proof"          "p" #'lsp-isar-insert-try0-proof)
      (:prefix ("s" . "Sledgehammer...")
                :desc "Open interface"        "s" #'lsp-isar-sledgehammer-interface
                :desc "Insert with interface" "S" #'lsp-isar-insert-sledgehammer-and-call
                :desc "Insert sledgehammer"   "i" #'lsp-isar-insert-sledgehammer)
        :desc "Insert auto"          "a" #'lsp-isar-insert-auto
        :desc "Insert simp"          "b" #'lsp-isar-insert-simp
        :desc "Insert meson"         "e" #'lsp-isar-insert-meson
        :desc "Insert fastforce"     "f" #'lsp-isar-insert-fastforce
        :desc "Insert algebra"       "g" #'lsp-isar-insert-algebra
        :desc "Insert linarith"      "l" #'lsp-isar-insert-linarith
        :desc "Insert force"         "F" #'lsp-isar-insert-force
        :desc "Insert fast"          "o" #'lsp-isar-insert-fast
        :desc "Insert presburger"    "p" #'lsp-isar-insert-presburger
        :desc "Insert argo"          "r" #'lsp-isar-insert-argo
        :desc "Insert satx"          "x" #'lsp-isar-insert-satx
        :desc "Insert proof outline" "P" #'lsp-isar-insert-proof-outline
        :desc "Delete windows"       "K" #'delete-other-windows) ;; not quite finished
