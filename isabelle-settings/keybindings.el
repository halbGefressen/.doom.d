;;; isabelle-settings/keybindings.el -*- lexical-binding: t; -*-
;; Accessible via SPC m
(map! :leader :map 'isar-mode-map :localleader
      (:prefix ("t" . "Try0...")
                :desc "Insert try0"           "t" #'lsp-isar-insert-try0
                :desc "Insert proof"          "p" #'lsp-isar-insert-try0-proof)
      (:prefix ("s" . "Sledgehammer...")
                :desc "Open interface"        "s" #'lsp-isar-sledgehammer-interface
                :desc "Insert with interface" "S" #'lsp-isar-insert-sledgehammer-and-call
                :desc "Insert sledgehammer"   "i" #'lsp-isar-insert-sledgehammer)
        :desc "Insert proof outline"    "P" #'lsp-isar-insert-proof-outline
        :desc "Delete windows"          "K" #'delete-other-windows ;; not quite finished
        :desc "Switch to output"        "a" (lambda () (interactive) (switch-to-buffer-other-window "*lsp-isar-output*"))
        :desc "Switch to state"         "i" (lambda () (interactive) (switch-to-buffer-other-window "*lsp-isar-state*"))
        :desc "Switch to progress"      "e" (lambda () (interactive) (switch-to-buffer-other-window "*lsp-isar-progress*"))
        :desc "Open panels"             "W" #'lsp-isar-open-output-and-progress-isabelle)
