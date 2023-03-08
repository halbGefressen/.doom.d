;;; themeswitcher.el -*- lexical-binding: t; -*-
(defvar pconfig-lightmode nil)
(defvar pconfig-darktheme 'doom-one)
(defvar pconfig-lighttheme 'doom-one-light)


(defun toggle-lightmode () (interactive)
       (if pconfig-lightmode
           (progn (consult-theme pconfig-darktheme) (setq pconfig-lightmode nil))
         (progn (consult-theme pconfig-lighttheme) (setq pconfig-lightmode t))))
