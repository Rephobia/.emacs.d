;; https://github.com/Wilfred/ag.el/#agel


(use-package ag
  :ensure t
  
  :config
  (setq ag-highlight-search t
	ag-group-matches nil
	ag-reuse-buffers t)
  
  :init
  (add-hook 'ag-mode-hook '(lambda () (switch-to-buffer-other-window "*ag search*")))
  
  )
