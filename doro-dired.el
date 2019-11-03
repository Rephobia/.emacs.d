
(use-package dired
  :init
  (setq dired-listing-switches "-aBhl  --group-directories-first")
  (put 'dired-find-alternate-file 'disabled nil)
  (put 'set-goal-column 'disabled nil)
  
  :bind
  (:map doro-mode-map
	("C-x C-d" . dired-jump)
	)
  
  )
