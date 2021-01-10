(use-package doomer/line-or-region
  :bind
  (:map doomer/keymap
	("C-w" . doomer/line-or-region-kill)
	("C-e" . doomer/line-or-region-copy)
	("C-d" . doomer/line-or-region-delete)
	)

  :init
  
  (defun doomer/is_lastline ()
    (if (= (point-max) (line-end-position))
	t
      nil))
  
  (defun doomer/line-or-region (func)
    (if (not (use-region-p))
	(funcall func (line-beginning-position)
		 (if (or (bound-and-true-p minibuffer-inactive-mode) (doomer/is_lastline))
		     (line-end-position)
		   (+ (line-end-position) 1)))
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

