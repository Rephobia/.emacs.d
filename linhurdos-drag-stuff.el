;; https://github.com/rejeep/drag-stuff.el


(use-package drag-stuff
  :ensure t
    
  :bind
  (:map linhurdos-mode-map
	("<C-i>" . drag-stuff-up)
	("C-k" . drag-stuff-down)
	("C-j" . drag-stuff-left)
	("C-l" . drag-right-stuff)
	)
  
  :init
  (drag-stuff-mode t)
  (define-key input-decode-map [?\C-i] [C-i])
  
  )
