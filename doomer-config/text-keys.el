
(use-package doomer/text
  :bind
  (:map doomer/keymap
	("C-t c" . capitalize-dwim)
	("C-t u" . upcase-dwim)
	("C-t d" . downcase-dwim)
	("C-t a" . align-regexp)
	("C-t r" . doomer/replace-string)
	)

  :init

  (defun doomer/replace-string ()
    (interactive)
    (if (boundp 'doomer/from-string)
	(setq doomer/from-string (read-string "from string: " doomer/from-string)
	      doomer/to-string (read-string "to-string: " doomer/to-string))
      (setq doomer/from-string (read-string "from string: ")
	    doomer/to-string (read-string "to-string: " )))
    (save-mark-and-excursion
      (replace-regexp doomer/from-string doomer/to-string
		      nil (region-beginning) (region-end))))
  
  )


(use-package doomer/line-or-region
  :bind
  (:map doomer/keymap
	("C-w" . doomer/line-or-region-kill)
	("C-e" . doomer/line-or-region-copy)
	("C-d" . doomer/line-or-region-delete)
	)

  :init
  
  (defun doomer/is_lastline ()
    (if (= (point-max) (line-end-position))
	t
      nil))
  
  (defun doomer/line-or-region (func)
    (if (not (use-region-p))
	(funcall func (line-beginning-position)
		 (if (or (bound-and-true-p minibuffer-inactive-mode) (doomer/is_lastline))
		     (line-end-position)
		   (+ (line-end-position) 1)))
      (funcall func (region-beginning) (region-end))))
  
  (defun doomer/line-or-region-kill ()
    (interactive)
    (doomer/line-or-region #'kill-region))
  
  (defun doomer/line-or-region-delete ()
    (interactive)
    (doomer/line-or-region #'delete-region))
  
  (defun doomer/line-or-region-copy ()
    (interactive)
    (doomer/line-or-region #'kill-ring-save))
  
  )


(use-package doomer/comment
  :bind
  (:map doomer/keymap
	("C-o"   . comment-line)
	("C-M-o" . comment-dwim)
	("C-S-o" . doomer/comment-copy)

	)

  :init
  
  (defun doomer/shift-region ()
    (let ((beg (save-excursion (goto-char (region-beginning))
			       (line-beginning-position)))
	  (end (save-excursion (goto-char (region-end))(line-end-position))))
      (if (> (point) (mark))
	  (progn (push-mark beg t t) (goto-char end))
	(progn (push-mark end t t) (goto-char beg)))
      ))

  (defun doomer/comment-copy ()
    "Comment and insert non-comment line or region.
    the function uses 'ć' register for copy. Copy buffer is not used."
    (interactive)
    (let ((beg (line-beginning-position))
	  (end (line-end-position)))
      (if (use-region-p)
	  (progn (doomer/shift-region)
		 (setq beg (region-beginning))
		 (setq end (region-end))
		 (goto-char (region-end))))
      (move-end-of-line 1)
      (copy-to-register ?ć beg end)
      (comment-region beg end)
      (newline 2)
      (insert-register ?ć)
      (exchange-point-and-mark)
      )
    )
  
  )


(use-package doomer/register
  :bind
  (:map doomer/keymap
	("C-r w" . doomer/kill-append-to-register)
	("C-r W" . doomer/kill-to-register)
	("C-r e" . doomer/append-to-register)
	("C-r E" . doomer/copy-to-register)
	("C-r v" . doomer/paste-from-register)
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
  
  )
