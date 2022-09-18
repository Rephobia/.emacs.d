(use-package just-mode
  :ensure t
  :hook ((just-mode . just-mode-indent-custom))

  :config
  (defun just-mode-indent-custom ()
    "just mode indent custom with 4 space"
    (setq indent-tabs-mode nil
	  tab-width 4
	  c-basic-offset 4))
  )
