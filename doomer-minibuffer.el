;; https://github.com/abo-abo/swiper

(use-package ivy
  :ensure t
  :bind
  (:map doomer-mode-map
	("C-s" . swiper)
	("C-x C-b" . ivy-switch-buffer)
	)
  (:map ivy-minibuffer-map
	("RET" . ivy-alt-done)
	("TAB" . ivy-partial)
	([remap doomer-scroll-half-page-down] . ivy-scroll-down-command)
	([remap doomer-scroll-half-page-up] . ivy-scroll-up-command)
	)
  
  :config
  
  (setq ivy-format-function 'ivy-format-function-line
	ivy-height 20
	ivy-use-virtual-buffers t)

  (defun sudo-find-file (file-name)
    "Like find file, but opens the file as root."
    (interactive "FSudo Find File: ")
    (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
      (find-file tramp-file-name)))
  
  )


(use-package smex
  :ensure t)


(use-package counsel
  :ensure t
  :after (smex)
  
  :bind
  (:map doomer-mode-map
	("C-x C-f" . counsel-find-file)
	("M-x" . counsel-M-x)
	("C-x C-v" . counsel-yank-pop)
	("C-h f" . counsel-describe-function)
	("C-h v" . counsel-describe-variable)
	("C-h l" . counsel-find-library)
	("C-h s" . counsel-info-lookup-symbol)
	("C-h c" . counsel-unicode-char)
	)
  :config
  (setq counsel-yank-pop-separator "\n\n----------------------------------------\n\n")
  
  )
