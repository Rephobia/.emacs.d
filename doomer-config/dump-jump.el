(use-package dumb-jump
  
  ;; https://github.com/jacktasia/dumb-jump
  
  :ensure t
  :bind
  (:map doomer/keymap
	("M-d d" . dumb-jump-go)
	("M-d b" . dumb-jump-back)
	("M-d o" . dumb-jump-go-other-window)
	("M-d p" . dumb-jump-go-prompt)
	)

  :config

  (setq dumb-jump-selector 'ivy
	dumb-jump-use-visible-window nil)

  )
