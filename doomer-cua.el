;; https://github.com/k-talo/volatile-highlights.el


(use-package undo-tree
  :ensure t
  :bind
  (:map doomer-mode-map
	("C-z"   . undo-tree-undo)
	("C-v"   . yank)
	("C-S-v" . yank-pop)

	("C-S-z" . undo-tree-redo)
	)

  :init
  
  (defun doomer-clear-kill-ring ()
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


(use-package doomer-cua
  :bind
  (:map doomer-mode-map
	("C-w"   . doomer-line-or-region-kill)
	("C-e"   . doomer-line-or-region-copy)
	("C-d"   . doomer-line-or-region-delete)

	("C-S-w" . doomer-line-above-kill)
	("C-S-d" . doomer-line-above-delete)

	("C-M-w" . doomer-line-below-kill)
	("C-M-d" . doomer-line-below-delete)
	)

  :init

  (defun doomer-line-of-region (func)
    (if (not (use-region-p))
	(funcall func (line-beginning-position) (line-end-position))
      (funcall func (region-beginning) (region-end))))

  (defun doomer-line-or-region-kill ()
    (interactive)
    (doomer-line-of-region #'kill-region))

  (defun doomer-line-or-region-delete ()
    (interactive)
    (doomer-line-of-region #'delete-region))

  (defun doomer-line-or-region-copy ()
    (interactive)
    (doomer-line-of-region #'kill-ring-save))

  (defun doomer-line-above-kill ()
    (interactive)
    (save-excursion (move-beginning-of-line nil) (kill-line -1)))

  (defun doomer-line-above-delete ()
    (interactive)
    (save-excursion (previous-line) (delete-region (line-beginning-position) (line-end-position))
		    (delete-char 1)))

  (defun doomer-line-below-kill ()
    (interactive)
    (save-excursion (next-line) (move-beginning-of-line nil) (kill-whole-line)))

  (defun doomer-line-below-delete ()
    (interactive)
    (save-excursion (next-line) (delete-region (line-beginning-position) (line-end-position))
		    (delete-char 1)))
  
  )
