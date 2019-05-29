;; https://github.com/k-talo/volatile-highlights.el


(use-package undo-tree
  :ensure t
  :bind
  (:map linhurdos-mode-map
	("C-z"   . undo-tree-undo)
	("C-v"   . yank)
	("C-S-v" . yank-pop)

	("C-S-z" . undo-tree-redo)
	)

  :init
  
  (defun linhurdos-clear-kill-ring ()
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


(use-package linhurdos-cua
  :bind
  (:map linhurdos-mode-map
	("C-w"   . linhurdos-line-or-region-kill)
	("C-e"   . linhurdos-line-or-region-copy)
	("C-d"   . linhurdos-line-or-region-delete)

	("C-S-w" . linhurdos-line-above-kill)
	("C-S-d" . linhurdos-line-above-delete)

	("C-M-w" . linhurdos-line-below-kill)
	("C-M-d" . linhurdos-line-below-delete)
	)

  :init

  (defun linhurdos-line-of-region (func)
    (if (not (use-region-p))
	(funcall func (line-beginning-position) (line-end-position))
      (funcall func (region-beginning) (region-end))))

  (defun linhurdos-line-or-region-kill ()
    (interactive)
    (linhurdos-line-of-region #'kill-region))

  (defun linhurdos-line-or-region-delete ()
    (interactive)
    (linhurdos-line-of-region #'delete-region))

  (defun linhurdos-line-or-region-copy ()
    (interactive)
    (linhurdos-line-of-region #'kill-ring-save))

  (defun linhurdos-line-above-kill ()
    (interactive)
    (save-excursion (move-beginning-of-line nil) (kill-line -1)))

  (defun linhurdos-line-above-delete ()
    (interactive)
    (save-excursion (previous-line) (delete-region (line-beginning-position) (line-end-position))
		    (delete-char 1)))

  (defun linhurdos-line-below-kill ()
    (interactive)
    (save-excursion (next-line) (move-beginning-of-line nil) (kill-whole-line)))

  (defun linhurdos-line-below-delete ()
    (interactive)
    (save-excursion (next-line) (delete-region (line-beginning-position) (line-end-position))
		    (delete-char 1)))
  
  )
