;; https://github.com/k-talo/volatile-highlights.el


(use-package undo-tree
  :ensure t
  :bind
  (:map doro-mode-map
	("C-z"   . undo-tree-undo)
	("C-v"   . yank)
	("C-S-v" . yank-pop)

	("C-S-z" . undo-tree-redo)
	)

  :init
  
  (defun doro-clear-kill-ring ()
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


(use-package doro-cua
  :bind
  (:map doro-mode-map
	("C-w"   . doro-line-or-region-kill)
	("C-e"   . doro-line-or-region-copy)
	("C-d"   . doro-line-or-region-delete)

	("C-S-w" . doro-line-above-kill)
	("C-S-d" . doro-line-above-delete)

	("C-M-w" . doro-line-below-kill)
	("C-M-d" . doro-line-below-delete)
	)

  :init

  (defun doro-line-of-region (func)
    (if (not (use-region-p))
	(funcall func (line-beginning-position) (line-end-position))
      (funcall func (region-beginning) (region-end))))

  (defun doro-line-or-region-kill ()
    (interactive)
    (doro-line-of-region #'kill-region))

  (defun doro-line-or-region-delete ()
    (interactive)
    (doro-line-of-region #'delete-region))

  (defun doro-line-or-region-copy ()
    (interactive)
    (doro-line-of-region #'kill-ring-save))

  (defun doro-line-above-kill ()
    (interactive)
    (save-excursion (move-beginning-of-line nil) (kill-line -1)))

  (defun doro-line-above-delete ()
    (interactive)
    (save-excursion (previous-line) (delete-region (line-beginning-position) (line-end-position))
		    (delete-char 1)))

  (defun doro-line-below-kill ()
    (interactive)
    (save-excursion (next-line) (move-beginning-of-line nil) (kill-whole-line)))

  (defun doro-line-below-delete ()
    (interactive)
    (save-excursion (next-line) (delete-region (line-beginning-position) (line-end-position))
		    (delete-char 1)))
  
  )
