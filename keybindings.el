;;; keybindings.el -*- lexical-binding: t; -*-

;; Navigation with SPC w arrowkeys
(map! :map evil-window-map
      [left]    #'evil-window-left
      [right]   #'evil-window-right
      [up]      #'evil-window-up
      [down]    #'evil-window-down)

(map! :map 'doom-leader-toggle-map
      :desc "Toggle light mode" "t" #'toggle-lightmode
      :desc "Maximize window"   "M" #'toggle-frame-maximized)

(map! :map 'evil-normal-state-map
      :desc "Switch window left" "[ w" #'evil-window-left
      :desc "Switch window right" "] w" #'evil-window-right)

(map! :leader :map 'treemacs-mode-map :localleader
      :desc "Switch workspace" "s" #'treemacs-switch-workspace
      :desc "Edit workspaces"  "e" #'treemacs-edit-workspaces
      :desc "Add project"      "a" #'treemacs-add-project-to-workspace
      :desc "Remove project"   "R" #'treemacs-remove-project-from-workspace
      :desc "Rename project"   "r" #'treemacs-rename-project)
