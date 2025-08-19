(use-package projectile
  
  ;; https://github.com/bbatsov/projectile
  
  :ensure t
  :delight
  
  :bind
  (:map projectile-mode-map
	("C-c" . projectile-command-map)
	("C-f" . projectile-find-file)
	("C-c C-s" . projectile-save-project-buffers)
	("C-b" . projectile-switch-to-buffer)

	("C-c C-p" . projectile-switch-project)

	("C-c s s" . counsel-git-grep)
	("C-c s g" . projectile-grep)
	("C-c x x" . doomer/run-konsole)
	("C-t" . doomer/run-vterm-toggle)
	("M-{" . projectile-previous-project-buffer)
	("M-}" . projectile-next-project-buffer)
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
    (doomer/run-external-terminal "st" "-d")
    )

  (defun doomer/run-konsole ()
    "Try to run konsole in (projectile-project-root)
if (projectile-project-rool) is nil, run konsole in file directory"
    (interactive)
    (doomer/run-external-terminal "konsole" "--workdir")
    )

  (defun doomer/run-external-terminal (terminal directory-option)
    "Try to run terminal in (projectile-project-root)
if (projectile-project-rool) is nil, run terminal in file directory"
    (if (projectile-project-root)
	(call-process terminal nil 0 nil directory-option (projectile-project-root))
      (call-process terminal nil 0)
      )
    )

  (defun doomer/run-vterm ()
    "Try to run vterm in (projectile-project-root)
if (projectile-project-rool) is nil, vterm st in file directory"
    (interactive)
    (if (projectile-project-root)
	(projectile-run-vterm)
      (vterm-toggle)
      )
    )

  (defun doomer/run-vterm-toggle ()
    "Try to run vterm in (projectile-project-root)
if (projectile-project-rool) is nil, vterm st in file directory
if current buffer is already vterm kill it"
    (interactive)
    (if (derived-mode-p 'vterm-mode)
	(quit-window)
      (doomer/run-vterm)
      )
    )
  
  :config
  (setq projectile-completion-system 'ivy)
  )
