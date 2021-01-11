(use-package js2-mode
  
  ;; https://github.com/mooz/js2-mode/
  
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  
  )
