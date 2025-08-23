(use-package doomer/text-edit
  :bind
  (:map doomer/keymap
	("C-p c" . capitalize-dwim)
	("C-p u" . upcase-dwim)
	("C-p d" . downcase-dwim)
	("C-p a" . align-regexp)
	("C-p r" . doomer/replace-string)
	)

  :init

  (defun doomer/replace-string ()
    (interactive)
    (if (boundp 'doomer/from-string)
	(setq doomer/from-string (read-string "from string: " doomer/from-string)
	      doomer/to-string (read-string "to-string: " doomer/to-string))
      (setq doomer/from-string (read-string "from string: ")
	    doomer/to-string (read-string "to-string: " )))
    (save-mark-and-excursion
      (replace-regexp doomer/from-string doomer/to-string
		      nil (region-beginning) (region-end))))

  
  (defun doomer/insert-current-date-and-time ()
    (interactive)
    (insert (format-time-string "%Y-%m-%d %H:%M:%S")))
  )
