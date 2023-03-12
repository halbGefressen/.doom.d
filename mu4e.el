;;; mu4e.el -*- lexical-binding: t; -*-

;; setup:
;; install mu & mbsync
;;
;;
;; authinfo.gpg:
;; ---
;; machine localhost login <email> port 1143 password <protonbridge-pw>
;; machine localhost login <email> port 1025 password <protonbridge-pw>
;;

(setq message-send-mail-function 'smtpmail-send-it
        smtpmail-auth-credentials "~/.authinfo.gpg"
        smtpmail-smtp-server "localhost"
        smtpmail-smtp-service 1025)
