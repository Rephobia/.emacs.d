;; https://github.com/k-talo/volatile-highlights.el


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
  
  (defun doomer/clear-kill-ring ()
    (interactive)
    (setq kill-ring 'nil)
    (message "kill ring cleaned"))
  
  )


(use-package volatile-highlights
  :ensure t
  :delight
  :init
  (volatile-highlights-mode t)
  
  )


(use-package doomer/cua
  :bind
  (:map doomer/keymap
	("C-w"   . doomer/line-or-region-kill)
	("C-e"   . doomer/line-or-region-copy)
	("C-d"   . doomer/line-or-region-delete)
	)

  :init

  (defun doomer/line-or-region (func)
    (if (not (use-region-p))
	(funcall func (line-beginning-position) (+ (line-end-position) 1))
      (funcall func (region-beginning) (region-end))))
  
  (defun doomer/line-or-region-kill ()
    (interactive)
    (doomer/line-or-region #'kill-region))
  
  (defun doomer/line-or-region-delete ()
    (interactive)
    (doomer/line-or-region #'delete-region))
  
  (defun doomer/line-or-region-copy ()
    (interactive)
    (doomer/line-or-region #'kill-ring-save))
  
  )
