(use-package iedit
  
  ;; https://github.com/victorhge/iedit
  
  :ensure t
  
  :bind
  
  (:map doomer/keymap
	("M-'" . iedit-mode)
	("M-\"" . doomer/iedit-scoped)
	)
  (:map iedit-mode-keymap
	("M-'" . iedit-mode)
	("M-\"" . iedit-toggle-selection)
	("M-C-'" . iedit-show/hide-unmatched-lines)
	("M-m" . iedit-switch-to-mc-mode)
	)
  
  :init

  (defun doomer/iedit-scoped ()
    "Run iedit-mode in current function are matched."
    (interactive)
    (iedit-mode 0))
  )
