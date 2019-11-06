;; https://github.com/mhayashi1120/Emacs-wgrep


(use-package wgrep-ag
  :ensure t
  :after ag
  
  :bind
  (:map doomer-mode-map
	("C-x w w" . wgrep-change-to-wgrep-mode)
	("C-x w k" . wgrep-abort-changes)
	)
  
  )
