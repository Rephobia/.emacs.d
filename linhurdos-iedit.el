;; https://github.com/victorhge/iedit


(use-package iedit
  :ensure t
  
  :bind
  (:map linhurdos-mode-map
	("M-'" . iedit-mode)
	("M-\"" . (lambda () "iedit local" (interactive) (iedit-mode 0)))
	)
  (:map iedit-mode-keymap
	("M-'" . iedit-mode)
	("M-\"" . iedit-toggle-selection)
	("M-C-'" . iedit-show/hide-unmatched-lines)
	("M-m" . iedit-switch-to-mc-mode)
	)
  
  )
