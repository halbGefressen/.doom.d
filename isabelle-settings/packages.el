;; -*- no-byte-compile: t; -*-
;;; isabelle-settings/packages.el


(package! isar-mode
   :recipe (:local-repo "~/repos/isar-mode"))

(package! isar-goal-mode
   :recipe (:local-repo "~/repos/isar-mode"))

(package! lsp-isar
   :recipe (:local-repo "~/Programme/isabelle-emacs/src/Tools/emacs-lsp/lsp-isar"))

(package! lsp-isar-parse-args
   :recipe (:local-repo "~/Programme/isabelle-emacs/src/Tools/emacs-lsp/lsp-isar"))

(package! session-async)
