;; https://github.com/MaskRay/ccls
;; https://github.com/MaskRay/emacs-ccls


(use-package ccls
  :ensure t
  :delight
  :hook ((c-mode c++-mode objc-mode) .
         (lambda () (require 'ccls) (lsp)))
  
  :config
  (setq ccls-executable "~/.emacs.d/ccls/Release/ccls"
	ccls-sem-highlight-method 'nil)
  )
