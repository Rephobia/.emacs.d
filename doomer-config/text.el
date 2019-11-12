
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

  (defun doomer/line-or-region (func)
    (if (not (use-region-p))
	(funcall func (line-beginning-position)
		 (if (bound-and-true-p minibuffer-inactive-mode)
		     (line-end-position)
		   (+ (line-end-position 1))))
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




(use-package undo-tree
  :ensure t
  :bind
  (:map doomer/keymap
	("C-z"   . undo-tree-undo)
	("C-v"   . yank)
	("C-S-v" . yank-pop)

	("C-S-z" . undo-tree-redo)
	)

  :init
  
  (defun doomer/clear-kill-ring ()
    (interactive)
    (setq kill-ring 'nil)
    (message "kill ring cleaned"))
  
  )


(use-package multiple-cursors
  
  ;; https://github.com/magnars/multiple-cursors.el
  
  :ensure t

  :init
  
  (define-key input-decode-map [?\C-m] [C-m])
  (define-key input-decode-map [?\C-i] [C-i])
  
  (define-key doomer/keymap (kbd "M-C-i") 'mc/mark-previous-like-this)
  (define-key doomer/keymap (kbd "M-C-k") 'mc/mark-next-like-this)
  (define-key doomer/keymap (kbd "<C-i>") 'mc/unmark-previous-like-this)
  (define-key doomer/keymap (kbd "C-k" ) 'mc/unmark-next-like-this)
  
  (define-key doomer/keymap (kbd "M-;") 'mc/mark-all-dwim)
  (define-key doomer/keymap (kbd "M-C-;") 'mc-hide-unmatched-lines-mode)
  (define-key doomer/keymap (kbd "M-:") 'mc/edit-lines)
  
  :config
  
  (setq mc/always-run-for-all 1)
  (define-key mc/keymap (kbd "<return>") nil)
  (define-key mc/keymap (kbd "C-v") 'yank)
  (define-key mc/keymap (kbd "C-n") 'mc/insert-numbers)
  (define-key mc/keymap (kbd "C-l") 'mc/insert-letters)

  )


(use-package iedit
  
  ;; https://github.com/victorhge/iedit
  
  :ensure t
  
  :bind
  
  (:map doomer/keymap
	("M-'" . iedit-mode)
	("M-\"" . doomer/iedit-scoped)
	)
  (:map iedit-mode-keymap
	("M-'" . iedit-mode)
	("M-\"" . iedit-toggle-selection)
	("M-C-'" . iedit-show/hide-unmatched-lines)
	("M-m" . iedit-switch-to-mc-mode)
	)
  
  :init

  (defun doomer/iedit-scoped ()
    "Run iedit-mode in current function are matched."
    (interactive)
    (iedit-mode 0))
  )


(use-package drag-stuff
  
  ;; https://github.com/rejeep/drag-stuff.el
  
  :ensure t
  
  :bind
  
  (:map doomer/keymap
	("M-p" . doomer/toggle-active-drag-mode)
	)
  (:map doomer/drag-mode-map
	("C-g" . doomer/drag-keyboard-quit)
	([remap previous-line] . drag-stuff-up)
	([remap next-line] . drag-stuff-down)
	)
  
  :init
  
  (defvar doomer/drag-mode-map (make-sparse-keymap)
    "Keymap while doomer/drag-mode is active. 
Goal of the keymap is to rebind C-g to conclude dragging.")

  (define-minor-mode doomer/drag-mode
    "Mode while dragging is active."
    :init-value nil
    doomer/drag-mode-map)
  
  (defun doomer/drag-keyboard-quit ()
    "Deactivate mark and exit doomer/drag-mode."
    (interactive)
    (doomer/drag-mode 0)
    (deactivate-mark))

  (defun doomer/turn-on-drag-mode ()
    (interactive)
    (doomer/drag-mode t))

  (defun doomer/turn-off-drag-mode ()
    (interactive)
    (doomer/drag-mode -1))
  
  (defun doomer/toggle-active-drag-mode ()
    (interactive)
    (if (bound-and-true-p doomer/drag-mode)
	(doomer/drag-keyboard-quit)
      (doomer/turn-on-drag-mode)
      )
    )
  
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
