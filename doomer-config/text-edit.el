(use-package doomer/text-edit
  :bind
  (:map doomer/keymap
	("C-t c" . capitalize-dwim)
	("C-t u" . upcase-dwim)
	("C-t d" . downcase-dwim)
	("C-t a" . align-regexp)
	("C-t r" . doomer/replace-string)
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
  
  )
