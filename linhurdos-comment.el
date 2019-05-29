
(use-package linhurdos-comment
  :bind
  (:map linhurdos-mode-map
	("C-o"   . comment-line)
	("C-M-o" . comment-dwim)
	("C-S-o" . linhurdos-comment-copy)

	("M-s M-s" . linhurdos-shift-region)
	)

  :init

  (defun linhurdos-shift-region ()
    (interactive)
    (let ((beg (save-excursion (goto-char (region-beginning))
			       (line-beginning-position)))
	  (end (save-excursion (goto-char (region-end))(line-end-position))))
      (if (> (point) (mark))
	  (progn (push-mark beg t t) (goto-char end))
	(progn (push-mark end t t) (goto-char beg)))
      ))

  (defun linhurdos-comment-copy ()
    "Comment and insert non-comment line or region.
    the function uses 'ć' register for copy, it doesn't push to copy buffer"
    (interactive)
    (let ((beg (line-beginning-position))
	  (end (line-end-position)))
      (if (use-region-p)
	  (progn (linhurdos-shift-region)
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
