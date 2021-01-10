(setq-default tab-width 8)

(use-package smart-tabs-mode
  :ensure t
  :init
  (smart-tabs-insinuate 'c 'c++ 'java 'javascript)
  
  )

(use-package js2-mode
  
  ;; https://github.com/mooz/js2-mode/
  
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  
  )
