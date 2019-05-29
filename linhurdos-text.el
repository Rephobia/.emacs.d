
(use-package linhurdos-text
  :bind
  (:map linhurdos-mode-map
	("C-t c" . capitalize-dwim)
	("C-t u" . upcase-dwim)
	("C-t d" . downcase-dwim)
	("C-t a" . align-regexp)
	("C-t r" . linhurdos-replace-string)
	)

  :init

  (defun linhurdos-replace-string ()
    (interactive)
    (if (boundp 'linhurdos-from-string)
	(setq linhurdos-from-string (read-string "from string: " linhurdos-from-string)
	      linhurdos-to-string (read-string "to-string: " linhurdos-to-string))
      (setq linhurdos-from-string (read-string "from string: ")
	    linhurdos-to-string (read-string "to-string: " )))
    (save-mark-and-excursion
      (replace-regexp linhurdos-from-string linhurdos-to-string
		      nil (region-beginning) (region-end))))
  
  )
