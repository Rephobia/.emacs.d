(use-package wgrep
  
  ;; https://github.com/mhayashi1120/Emacs-wgrep
  
  :ensure t
  
  :bind
  (:map doomer/keymap
	("C-x w w" . wgrep-change-to-wgrep-mode)
	("C-x w g" . wgrep-abort-changes)
	)
  )
