
(use-package doomer-shell
  :bind
  (:map minibuffer-local-shell-command-map
	("M-p" . previous-history-element)
	("M-;" . next-history-element)
	)
  (:map shell-mode-map
	("M-p" . comint-previous-input)
	("M-;" . comint-next-input)	       
	)
  )
