(use-package doomer/text-edit
  :bind
  (:map doomer/keymap
	("M-t c" . capitalize-dwim)
	("M-t u" . upcase-dwim)
	("M-t d" . downcase-dwim)
	("M-t a" . align-regexp)
	("M-t r" . doomer/replace-string)
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
