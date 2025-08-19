(use-package company
  
  ;; https://github.com/company-mode/company-mode
  
  :ensure t
  :delight
  :bind
  (:map company-active-map
	([remap previous-line]. company-select-previous)
	([remap next-line] . company-select-next)
	)
  
  :hook (after-init . global-company-mode)

  ;; :init
  ;; (add-hook 'after-init-hook 'global-company-mode)
  
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay 0.1)
  (company-minimum-prefix-length 1)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)

  )
