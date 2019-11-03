
(use-package doro-text
  :bind
  (:map doro-mode-map
	("C-t c" . capitalize-dwim)
	("C-t u" . upcase-dwim)
	("C-t d" . downcase-dwim)
	("C-t a" . align-regexp)
	("C-t r" . doro-replace-string)
	)

  :init

  (defun doro-replace-string ()
    (interactive)
    (if (boundp 'doro-from-string)
	(setq doro-from-string (read-string "from string: " doro-from-string)
	      doro-to-string (read-string "to-string: " doro-to-string))
      (setq doro-from-string (read-string "from string: ")
	    doro-to-string (read-string "to-string: " )))
    (save-mark-and-excursion
      (replace-regexp doro-from-string doro-to-string
		      nil (region-beginning) (region-end))))
  
  )
