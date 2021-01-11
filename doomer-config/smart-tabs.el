(setq-default tab-width 8)

(use-package smart-tabs-mode
  :ensure t
  :init
  (smart-tabs-insinuate 'c 'c++ 'java 'javascript)
  
  )
