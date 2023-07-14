;;; keybindings.el -*- lexical-binding: t; -*-

;; Navigation with SPC w arrowkeys
(map! :map evil-window-map
      [left]    #'evil-window-left
      [right]   #'evil-window-right
      [up]      #'evil-window-up
      [down]    #'evil-window-down)

(map! :map evil-motion-state-map
      [up]      #'evil-previous-visual-line
      [down]    #'evil-next-visual-line
      [home]    #'evil-beginning-of-visual-line
      [end]     #'evil-end-of-visual-line)

(map! :map 'doom-leader-toggle-map
      :desc "Toggle light mode" "t" #'toggle-lightmode
      :desc "Toggle tab bars"   "T" #'centaur-tabs-mode
      :desc "Maximize window"   "M" #'toggle-frame-maximized)

(map! :leader (:prefix ("r" . "Movement")
               :desc "Left window"      "i" #'evil-window-left
               :desc "Right window"     "e" #'evil-window-right
               :desc "Top window"       "l" #'evil-window-up
               :desc "Bottom window"    "a" #'evil-window-down
               :desc "Next Frame"       "c" #'+evil/next-frame
               :desc "Previous Frame"   "v" #'+evil/previous-frame
               :desc "Switch buffer"    "b" #'consult-buffer
               ))

(map! :map 'evil-normal-state-map
      :desc "Switch window left" "[ w" #'evil-window-left
      :desc "Switch window right" "] w" #'evil-window-right)

(map! :leader :map 'treemacs-mode-map :localleader
      :desc "Switch workspace" "s" #'treemacs-switch-workspace
      :desc "Edit workspaces"  "e" #'treemacs-edit-workspaces
      :desc "Add project"      "a" #'treemacs-add-project-to-workspace
      :desc "Remove project"   "R" #'treemacs-remove-project-from-workspace
      :desc "Rename project"   "r" #'treemacs-rename-project)

;; amogus
(map! :map 'doom-leader-insert-map
      :desc "Amogus" "a" #'(lambda () (interactive) (insert-char 3486 1 t)))
