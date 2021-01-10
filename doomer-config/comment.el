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
