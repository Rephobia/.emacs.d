(use-package doomer/register
  :bind
  (:map doomer/keymap
	("C-r w" . doomer/kill-append-to-register)
	("C-r W" . doomer/kill-to-register)
	("C-r e" . doomer/append-to-register)
	("C-r E" . doomer/copy-to-register)
	("C-r V" . doomer/paste-from-register)

	("C-r r" . xah-copy-to-register-1)
	("C-r v" . xah-paste-from-register-1)

	)

  :init

  (setq register-preview-delay 0)
  (setq register-separator ?+)
  (set-register register-separator "\n\n")

  (defun doomer/kill-append-to-register (reg)
    "kill and append line or region to register"
    (interactive (list (register-read-with-preview "Kill append to register: ")))
    (if (not (use-region-p))
  	(append-to-register reg (line-beginning-position) (line-end-position) -1)
      (append-to-register reg (region-beginning) (region-end) -1))
    (message "Kill append to register: 「%c」" reg))

  (defun doomer/kill-to-register (reg)
    "kill line or region to register"
    (interactive (list (register-read-with-preview "Kill to register: ")))
    (if (not (use-region-p))
  	(copy-to-register reg (line-beginning-position) (line-end-position) -1)
      (copy-to-register reg (region-beginning) (region-end) -1))
    (message "Kill to register: 「%c」" reg))

  (defun doomer/append-to-register (reg)
    "append line or region to register"
    (interactive (list (register-read-with-preview "Append to register: ")))
    (if (not (use-region-p))
  	(append-to-register reg (line-beginning-position) (line-end-position))
      (append-to-register reg (region-beginning) (region-end)))
    (message "Append to register: 「%c」" reg))

  (defun doomer/copy-to-register (reg)
    "copy line or region to register"
    (interactive (list (register-read-with-preview "Copy to register: ")))
    (if (not (use-region-p))
  	(copy-to-register reg (line-beginning-position) (line-end-position))
      (copy-to-register reg (region-beginning) (region-end)))
    (message "Copy to register: 「%c」" reg))

  (defun doomer/paste-from-register (reg)
    "paste from register"
    (interactive (list (register-read-with-preview "Insert from register: ")))
    (when (use-region-p)
      (delete-region (region-beginning) (region-end)))
    (insert-register reg))

  (defun xah-copy-to-register-1 ()
    "Copy current line or text selection to register 1.
See also: `xah-paste-from-register-1', `copy-to-register'.

URL `http://ergoemacs.org/emacs/elisp_copy-paste_register_1.html'
Version 2017-01-23"
    (interactive)
    (let ($p1 $p2)
      (if (region-active-p)
	  (progn (setq $p1 (region-beginning))
		 (setq $p2 (region-end)))
	(progn (setq $p1 (line-beginning-position))
	       (setq $p2 (line-end-position))))
      (copy-to-register ?1 $p1 $p2)
      (message "Copied to register 1: 「%s」." (buffer-substring-no-properties $p1 $p2))))

  (defun xah-paste-from-register-1 ()
    "Paste text from register 1.
See also: `xah-copy-to-register-1', `insert-register'.
URL `http://ergoemacs.org/emacs/elisp_copy-paste_register_1.html'
Version 2015-12-08"
    (interactive)
    (when (use-region-p)
      (delete-region (region-beginning) (region-end)))
    (insert-register ?1 t))
  )
