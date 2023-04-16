(use-package undo-tree
  :ensure t
  :bind
  (:map doomer/keymap
	("C-z"   . undo-tree-undo)
	("C-v"   . yank)
	("C-S-v" . yank-pop)

	("C-S-z" . undo-tree-redo)
	)

  :init
  (global-undo-tree-mode)
  (setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  (defun doomer/clear-kill-ring ()
    (interactive)
    (setq kill-ring 'nil)
    (message "kill ring cleaned"))
  
  )
