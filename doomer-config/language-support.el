(setq-default tab-width 8)

(use-package smart-tabs-mode
  :ensure t
  :init
  (smart-tabs-insinuate 'c 'c++ 'java 'javascript)
  
  )


(use-package lsp-mode
  
  ;; https://github.com/emacs-lsp/lsp-mode
  
  :ensure t
  :delight
  
  :bind
  (:map doomer/keymap
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
  
  ;; https://github.com/tigersoldier/company-lsp
  
  :ensure t
  :commands company-lsp
  
  :config
  (setq company-lsp-enable-snippet t
	company-lsp-enable-recompletion t
  	company-lsp-async t
	company-lsp-cache-candidates nil)
  (push 'company-lsp company-backends)
  
  )


(use-package ccls

  ;; https://github.com/MaskRay/ccls
  ;; https://github.com/MaskRay/emacs-ccls

  
  :ensure t
  :delight
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp)))
  
  :config
  (setq ccls-executable "~/.emacs.d/ccls/Release/ccls"
	ccls-sem-highlight-method 'nil)
  )


(use-package js2-mode
  
  ;; https://github.com/mooz/js2-mode/
  
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  
  )
