(use-package avy
  
  ;; https://github.com/abo-abo/avy
  
  :ensure t
  
  :bind
  (:map doomer/keymap
	("M-1" . avy-goto-line)
	("M-2" . avy-goto-char-timer)
	("M-!" . doomer/avy-mark-line)
	("M-@" . doomer/avy-mark-char-timer)
	)

  :config
  (avy-setup-default)
  (setq avy-background t
	avy-case-fold-search nil
	avy-all-windows t
	avy-style 'pre
	avy-highlight-first t
	avy-keys '(?q ?w ?e ?r
		      ?a ?s ?d ?f
		      ?i ?o ?p
		      ?j ?k ?l))

  :init

  (defun doomer/avy-mark-line ()
    (interactive)
    (if (not (use-region-p))
	(progn (push-mark (point) t t) (avy-goto-line))
      (avy-goto-line)))

  (defun doomer/avy-mark-char-timer ()
    (interactive)
    (if (not (use-region-p))
	(progn (push-mark (point) t t) (avy-goto-char-timer))
      (avy-goto-char-timer)))
  
  (eval-after-load "avy"
    '(defun avy--read-candidates (&optional re-builder)
       "Read as many chars as possible and return their occurrences.
At least one char must be read, and then repeatedly one next char
may be read if it is entered before `avy-timeout-seconds'.  DEL
deletes the last char entered, and RET exits with the currently
read string immediately instead of waiting for another char for
`avy-timeout-seconds'.
The format of the result is the same as that of `avy--regex-candidates'.
This function obeys `avy-all-windows' setting.
RE-BUILDER is a function that takes a string and returns a regex.
When nil, `regexp-quote' is used.
If a group is captured, the first group is highlighted.
Otherwise, the whole regex is highlighted."
       (let ((str "")
	     (re-builder (or re-builder #'regexp-quote))
	     char break overlays regex)
	 (unwind-protect
	     (progn
	       (avy--make-backgrounds
		(avy-window-list))
	       (while (and (not break)
			   (setq char
				 (read-char (format "%d  char%s: "
						    (length overlays)
						    (if (string= str "")
							str
						      (format " (%s)" str)))
					    t
					    (and (not (string= str ""))
						 avy-timeout-seconds))))
		 ;; Unhighlight
		 (dolist (ov overlays)
		   (delete-overlay ov))
		 (setq overlays nil)
		 (cond
		  ;; Handle RET
		  ((= char 13)
		   (setq str (concat str (list ?\n)) ;; RET can be candidate, and break without timer
			 break t
			 ))
		  ;; Handle C-h, DEL
		  ((memq char avy-del-last-char-by)
		   (let ((l (length str)))
		     (when (>= l 1)
		       (setq str (substring str 0 (1- l))))))
		  ;; Handle ESC
		  ((= char 27)
		   (keyboard-quit))
		  (t
		   (setq str (concat str (list char)))))
		 ;; Highlight
		 (when (>= (length str) 1)
		   (let ((case-fold-search
			  (or avy-case-fold-search (string= str (downcase str))))
			 found)
		     (avy-dowindows current-prefix-arg
		       (dolist (pair (avy--find-visible-regions
				      (window-start)
				      (window-end (selected-window) t)))
			 (save-excursion
			   (goto-char (car pair))
			   (setq regex (funcall re-builder str))
			   (while (re-search-forward regex (cdr pair) t)
			     (unless (not (avy--visible-p (1- (point))))
			       (let* ((idx (if (= (length (match-data)) 4) 1 0))
				      (ov (make-overlay
					   (match-beginning idx) (match-end idx))))
				 (setq found t)
				 (push ov overlays)
				 (overlay-put
				  ov 'window (selected-window))
				 (overlay-put
				  ov 'face 'avy-goto-char-timer-face)))))))
		     ;; No matches at all, so there's surely a typo in the input.
		     (unless found (beep)))))
	       (nreverse (mapcar (lambda (ov)
				   (cons (cons (overlay-start ov)
					       (overlay-end ov))
					 (overlay-get ov 'window)))
				 overlays)))
	   (dolist (ov overlays)
	     (delete-overlay ov))
	   (avy--done))))
    )
  
  )
