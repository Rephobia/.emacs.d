(use-package projectile
  
  ;; https://github.com/bbatsov/projectile
  
  :ensure t
  :delight
  
  :bind
  (:map projectile-mode-map
	("C-c" . projectile-command-map)
	("C-c C-f" . projectile-find-file)
	("C-c C-s" . projectile-save-project-buffers)

	("C-c C-p" . projectile-switch-project)

	("C-c s s" . counsel-git-grep)
	("C-c s g" . projectile-grep)
	("C-c x x" . doomer/run-st)
	)
  :init
  
  (use-package counsel-projectile
    
    ;; https://github.com/ericdanan/counsel-projectile
    
    :ensure t)
  
  (projectile-mode +1)

  (defun doomer/run-st ()
    "Try to run st in (projectile-project-root)
if (projectile-project-rool) is nil, run st in file directory"
    (interactive)
    (if (projectile-project-root)
	(call-process "st" nil 0 nil "-d" (projectile-project-root))
      (call-process "st" nil 0)
      )
    )
  
  :config
  (setq projectile-completion-system 'ivy)
  
  )
