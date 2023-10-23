;;; lspsettings.el -*- lexical-binding: t; -*-


;; Haskell language server
(setq lsp-haskell-server-path "~/.ghcup/bin/haskell-language-server-wrapper")

;; LSP+clangd
(setq lsp-clients-clangd-args '("-j=3"
				"--background-index"
				"--clang-tidy"
				"--completion-style=detailed"
				"--header-insertion=never"
				"--header-insertion-decorators=0"
                                "--enable-config"))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

;; Semantic highlighting
(add-hook 'lsp-mode-hook 'lsp-semantic-tokens-mode)
