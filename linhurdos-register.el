
(use-package linhurdos-register
  :bind
  (:map linhurdos-mode-map
	("C-r w" . linhurdos-kill-append-to-register)
	("C-r W" . linhurdos-kill-to-register)
	("C-r e" . linhurdos-append-to-register)
	("C-r E" . linhurdos-copy-to-register)
	("C-r v" . linhurdos-paste-from-register)
	)
  
  :init
  
  (setq register-preview-delay 0)
  (setq register-separator ?+)
  (set-register register-separator "\n\n")

  (defun linhurdos-kill-append-to-register (reg)
    "kill and append line or region to register"
    (interactive (list (register-read-with-preview "Kill append to register: ")))
    (if (not (use-region-p))
  	(append-to-register reg (line-beginning-position) (line-end-position) -1)
      (append-to-register reg (region-beginning) (region-end) -1))
    (message "Kill append to register: 「%c」" reg))

  (defun linhurdos-kill-to-register (reg)
    "kill line or region to register"
    (interactive (list (register-read-with-preview "Kill to register: ")))
    (if (not (use-region-p))
  	(copy-to-register reg (line-beginning-position) (line-end-position) -1)
      (copy-to-register reg (region-beginning) (region-end) -1))
    (message "Kill to register: 「%c」" reg))

  (defun linhurdos-append-to-register (reg)
    "append line or region to register"
    (interactive (list (register-read-with-preview "Append to register: ")))
    (if (not (use-region-p))
  	(append-to-register reg (line-beginning-position) (line-end-position))
      (append-to-register reg (region-beginning) (region-end)))
    (message "Append to register: 「%c」" reg))

  (defun linhurdos-copy-to-register (reg)
    "copy line or region to register"
    (interactive (list (register-read-with-preview "Copy to register: ")))
    (if (not (use-region-p))
  	(copy-to-register reg (line-beginning-position) (line-end-position))
      (copy-to-register reg (region-beginning) (region-end)))
    (message "Copy to register: 「%c」" reg))

  (defun linhurdos-paste-from-register (reg)
    "paste from register"
    (interactive (list (register-read-with-preview "Insert from register: ")))
    (when (use-region-p)
      (delete-region (region-beginning) (region-end)))
    (insert-register reg))
  
  )
