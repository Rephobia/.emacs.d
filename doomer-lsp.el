;; https://github.com/emacs-lsp/lsp-mode
;; https://github.com/tigersoldier/company-lsp


(use-package lsp-mode
  :ensure t
  :delight
  
  :bind
  (:map doomer-mode-map
	("M-f d" . xref-find-definitions-other-window)
	)
  
  :hook
  (c++-mode . lsp)
  
  :config
  (setq lsp-enable-on-type-formatting nil
	lsp-prefer-flymake nil)
  
  :commands
  lsp
  
  )


(use-package company-lsp
  :ensure t
  :commands company-lsp
  
  :config
  (setq company-lsp-enable-snippet t
	company-lsp-enable-recompletion t
  	company-lsp-async t
	company-lsp-cache-candidates nil)
  (push 'company-lsp company-backends)
  
  )
