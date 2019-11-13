

(use-package projectile
  
  ;; https://github.com/bbatsov/projectile
  
  :ensure t
  :delight
  
  :bind
  (:map projectile-mode-map
	("C-c" . projectile-command-map)
	("C-c C-f" . projectile-find-file)
	("C-c C-s" . projectile-save-project-buffers)

	("C-c C-b" . counsel-projectile)
	("C-c C-p" . projectile-switch-project)

	("C-c s s" . counsel-git-grep)
	("C-c s g" . projectile-grep)
	("C-c x x" . doomer/run-lxterminal)
	)
  :init
  
  (use-package counsel-projectile
    
    ;; https://github.com/ericdanan/counsel-projectile
    
    :ensure t)
  
  (projectile-mode +1)

  (defun doomer/run-lxterminal ()
    (interactive)
    (start-process-shell-command "lxterminal" nil (concat "lxterminal --working-directory="
							  (projectile-project-root)))
    )
  
  :config
  (setq projectile-completion-system 'ivy)  
  )


(use-package wgrep
  
  ;; https://github.com/mhayashi1120/Emacs-wgrep
  
  :ensure t
  
  :bind
  (:map doomer/keymap
	("C-x w w" . wgrep-change-to-wgrep-mode)
	("C-x w g" . wgrep-abort-changes)
	)
  )


(use-package company
  
  ;; https://github.com/company-mode/company-mode
  
  :ensure t
  :delight
  :bind
  (:map company-active-map
	([remap previous-line]. company-select-previous)
	([remap next-line] . company-select-next)
	)
  
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  
  :custom
  (company-begin-commands '(self-insert-command))
  (company-idle-delay .0)
  (company-minimum-prefix-length 2)
  (company-show-numbers t)
  (company-tooltip-align-annotations 't)

  )
