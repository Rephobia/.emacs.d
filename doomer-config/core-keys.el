
(defun doomer/mark (movement-function)
  (if (not (use-region-p))
      (progn (push-mark (point) t t)
	     (funcall movement-function))
    (funcall movement-function)))


(use-package doomer/basic
  :bind
  (:map doomer/keymap
	("M-i" . previous-line)
	("M-I" . doomer/previous-line-mark)
	("M-k" . next-line)
	("M-K" . doomer/next-line-mark)

	("M-j" . backward-char)
	("M-J" . doomer/backward-char-mark)
	("M-l" . forward-char)
	("M-L" . doomer/forward-char-mark)

	("M-q" . beginning-of-line)
	("M-Q" . doomer/beginning-of-line-mark)
	("M-a" . end-of-line)
	("M-A" . doomer/end-of-line-mark)

	("M-," . beginning-of-buffer)
	("M-<" . doomer/beginning-of-buffer-mark)
	("M-." . end-of-buffer)
	("M->" . doomer/end-of-buffer-mark)

	)

  :init

  (defun doomer/previous-line-mark ()
    (interactive)
    (doomer/mark #'previous-line))

  (defun doomer/next-line-mark ()
    (interactive)
    (doomer/mark #'next-line))

  (defun doomer/backward-char-mark ()
    (interactive)
    (doomer/mark #'backward-char))

  (defun doomer/forward-char-mark ()
    (interactive)
    (doomer/mark #'forward-char))

  (defun doomer/beginning-of-line-mark ()
    (interactive)
    (doomer/mark #'beginning-of-line))

  (defun doomer/end-of-line-mark ()
    (interactive)
    (doomer/mark #'end-of-line))

  (defun doomer/beginning-of-buffer-mark ()
    (interactive)
    (doomer/mark #'beginning-of-buffer))

  (defun doomer/end-of-buffer-mark ()
    (interactive)
    (doomer/mark #'end-of-buffer))
  )


(use-package doomer/word
  :bind
  (:map doomer/keymap
	("M-u" . doomer/word-backward)
	("M-U" . doomer/word-backward-mark)
	("M-o" . doomer/word-forward)
	("M-O" . doomer/word-forward-mark)
	("M-DEL" . doomer/delete-word-backward)
	("M-<delete>" . doomer/delete-word-forward)
	)

  :init
  
  (defun doomer/word-comprehend-backward (char-function)
    "passed function processes words consisting only of alphabetic characters"
    (let ((case-fold-search nil))
      (cond ((looking-back "[^[:alpha:]]\\|[A-Z]\\|[А-Я]") (funcall char-function))
	    ((while (looking-back "[a-z]\\|[а-я]") (funcall char-function)))
	    ((looking-back "[A-Z]\\|[А-Я]") (funcall char-function)))))

  (defun doomer/word-comprehend-forward (char-function)
    "passed function processes words consisting only of alphabetic characters"
    (let ((case-fold-search nil))
      (cond ((looking-at "[^[:alpha:]]") (funcall char-function))
  	    ((looking-at "[A-Z]\\|[А-Я]\\|[a-z]\\|[а-я]") (funcall char-function)
  	     (while (looking-at "[a-z]\\|[а-я]") (funcall char-function))))))

  (defun doomer/word-backward ()
    (interactive)
    (doomer/word-comprehend-backward #'backward-char))

  (defun doomer/word-forward ()
    (interactive)
    (doomer/word-comprehend-forward #'forward-char))

  (defun doomer/delete-word-backward ()
    (interactive)
    (doomer/word-comprehend-backward (lambda () (delete-backward-char 1))))

  (defun doomer/delete-word-forward ()
    (interactive)
    (doomer/word-comprehend-forward (lambda () (delete-forward-char 1))))

  (defun doomer/word-backward-mark ()
    (interactive)
    (doomer/mark #'doomer/word-backward))

  (defun doomer/word-forward-mark ()
    (interactive)
    (doomer/mark #'doomer/word-forward))

  )


(use-package doomer/window
  :bind
  (:map doomer/keymap
	("C-q" . doomer/scroll-half-page-down)
	("C-a" . doomer/scroll-half-page-up)
	("C-S-q". recenter-top-bottom)
	("C-S-a". recenter)

	("M-[" . previous-buffer)
	("M-]" . next-buffer)

	("C-<left>"  . enlarge-window-horizontally)
	("C-<right>" . shrink-window-horizontally)
	("C-<up>"    . enlarge-window)
	("C-<down>" . (lambda () (interactive) (enlarge-window -1)))
	)

  :init

  (defun doomer/scroll-half-page-down ()
    (interactive)
    "scroll down half the page"
    (scroll-down (- (/ (window-body-height) 2) 1)))

  (defun doomer/scroll-half-page-up ()
    (interactive)
    "scroll up half the page"
    (scroll-up (- (/ (window-body-height) 2) 1)))

  )


(use-package doomer/shell
  :bind
  (:map minibuffer-local-shell-command-map
	([remap previous-line] . previous-history-element)
	([remap next-line] . next-history-element)
	)
  (:map shell-mode-map
	([remap previous-line] . comint-previous-input)
	([remap next-line] . comint-next-input)	       
	)
  )


(use-package dired
  :init
  (setq dired-listing-switches "-aBhl  --group-directories-first")
  (put 'dired-find-alternate-file 'disabled nil)
  (put 'set-goal-column 'disabled nil)
  
  :bind
  (:map doomer/keymap
	("C-x C-d" . dired-jump)
	)
  
  )


(use-package ace-window

  ;; https://github.com/abo-abo/ace-window
  
  :ensure t
  
  :bind
  (:map doomer/keymap
	("M-w" . ace-window)
	)

  :config
  
  (setq aw-keys '(?q ?w ?e ?r)
	aw-background t
	aw-dispatch-always t
	aw-dispatch-alist
	'((?x aw-delete-window "Ace - Delete Window")
	  (?d delete-window)
	  (?D delete-other-windows)

	  (?k kill-this-buffer)
	  (?K kill-buffer-and-window)
	  (?c doomer/kill-compilation-buf)

	  (?s aw-swap-window "Ace - Swap Window")
	  (?1 doomer/split-focus-window-v)
	  (?2 doomer/split-focus-window-h)
	  (?b balance-windows)
	  ))

  (defun doomer/split-focus-window-h ()
    (split-window-horizontally)
    (other-window 1))

  (defun doomer/split-focus-window-v ()
    (split-window-vertically)
    (other-window 1))

  (defun doomer/kill-compilation-buf ()
    (kill-buffer "*compilation*"))

  )

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

