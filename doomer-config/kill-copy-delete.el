(use-package doomer/kill-copy-delete
  :bind
  (:map doomer/keymap
	("C-w" . doomer/kill)
	("C-e" . doomer/copy)
	("C-d" . doomer/delete)
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
  
  (defun doomer/kill ()
    (interactive)
    (doomer/line-or-region #'kill-region))
  
  (defun doomer/delete ()
    (interactive)
    (doomer/line-or-region #'delete-region))
  
  (defun doomer/copy ()
    (interactive)
    (doomer/line-or-region #'kill-ring-save))
  
  )

