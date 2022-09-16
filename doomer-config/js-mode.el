(use-package js2-mode
  
  ;; https://github.com/mooz/js2-mode/
  
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  
  )

(use-package js-doc
  :ensure t

  :hook ((js2-mode . (lambda ()
		       (define-key js2-mode-map (kbd "<C-tab>") 'js-doc-insert-function-doc)
		       (define-key js2-mode-map "@" 'js-doc-insert-tag))))
)
