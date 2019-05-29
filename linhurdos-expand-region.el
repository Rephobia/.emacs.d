;; https://github.com/magnars/expand-region.el


(use-package expand-region
  :ensure t
  
  :bind
  (:map linhurdos-mode-map
	("M-s s" . er/mark-inside-pairs)
	("M-s S" . er/mark-outside-pairs)

	("M-s q" . er/mark-inside-quotes)
	("M-s Q" . er/mark-outside-quotes)

	("M-s w" . er/mark-word)
	("M-s W" . er/mark-symbol)
	("M-s d" . er/mark-defun)
	("M-s c" . er/mark-comment)
	)
  
  )
