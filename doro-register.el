
(use-package doro-register
  :bind
  (:map doro-mode-map
	("C-r w" . doro-kill-append-to-register)
	("C-r W" . doro-kill-to-register)
	("C-r e" . doro-append-to-register)
	("C-r E" . doro-copy-to-register)
	("C-r v" . doro-paste-from-register)
	)
  
  :init
  
  (setq register-preview-delay 0)
  (setq register-separator ?+)
  (set-register register-separator "\n\n")

  (defun doro-kill-append-to-register (reg)
    "kill and append line or region to register"
    (interactive (list (register-read-with-preview "Kill append to register: ")))
    (if (not (use-region-p))
  	(append-to-register reg (line-beginning-position) (line-end-position) -1)
      (append-to-register reg (region-beginning) (region-end) -1))
    (message "Kill append to register: 「%c」" reg))

  (defun doro-kill-to-register (reg)
    "kill line or region to register"
    (interactive (list (register-read-with-preview "Kill to register: ")))
    (if (not (use-region-p))
  	(copy-to-register reg (line-beginning-position) (line-end-position) -1)
      (copy-to-register reg (region-beginning) (region-end) -1))
    (message "Kill to register: 「%c」" reg))

  (defun doro-append-to-register (reg)
    "append line or region to register"
    (interactive (list (register-read-with-preview "Append to register: ")))
    (if (not (use-region-p))
  	(append-to-register reg (line-beginning-position) (line-end-position))
      (append-to-register reg (region-beginning) (region-end)))
    (message "Append to register: 「%c」" reg))

  (defun doro-copy-to-register (reg)
    "copy line or region to register"
    (interactive (list (register-read-with-preview "Copy to register: ")))
    (if (not (use-region-p))
  	(copy-to-register reg (line-beginning-position) (line-end-position))
      (copy-to-register reg (region-beginning) (region-end)))
    (message "Copy to register: 「%c」" reg))

  (defun doro-paste-from-register (reg)
    "paste from register"
    (interactive (list (register-read-with-preview "Insert from register: ")))
    (when (use-region-p)
      (delete-region (region-beginning) (region-end)))
    (insert-register reg))
  
  )
