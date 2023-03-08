;;; isabelle-settings/keybindings.el -*- lexical-binding: t; -*-

(map! :desc "Bonk" "C-ẞ" #'lsp-isar-insert-sledgehammer-and-call
      :desc "try0" "C-ß" #'lsp-isar-insert-try0)
;; Accessible via SPC m
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
