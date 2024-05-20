;; -*- no-byte-compile: t; -*-
;;; isabelle-settings/packages.el


(package! isar-mode :recipe (:host github :repo "m-fleury/isar-mode") :pin "8e5a931939b27b2dd9e153209bf26dea5ab342cc")


(package! lsp-isar
   :recipe (:host github
            :repo "m-fleury/isabelle-emacs"
            :branch "Isabelle2023-vsce"
            :files ("src/Tools/emacs-lsp/lsp-isar/*.el"))
   :pin "bd8fd356fbd373ff9e78cea09a58ba6de1d6ccfc")

(package! session-async)
