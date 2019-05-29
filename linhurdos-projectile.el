;; Projectile                             https://github.com/bbatsov/projectile
;; Counsel-projectile           https://github.com/ericdanan/counsel-projectile


(use-package projectile
  :ensure t
  :delight
  
  :bind
  (:map projectile-mode-map
	("C-c" . projectile-command-map)
	("C-c C-f" . projectile-find-file)
	("C-c C-s" . projectile-save-project-buffers)

	("C-c C-b" . counsel-projectile)
	("C-c C-p" . projectile-switch-project)

	("C-c s s" . counsel-projectile-ag)
	("C-c s S" . counsel-git-grep)
	("C-c s a" . projectile-ag)
	("C-c s g" . projectile-grep)
	)
  :init
  
  (use-package counsel-projectile
    :ensure t)
 
  (projectile-mode +1)
  
  :config
  (setq projectile-completion-system 'ivy)
  
  )
