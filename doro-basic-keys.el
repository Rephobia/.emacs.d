
(defun doro-mark (movement-function)
  (if (not (use-region-p))
      (progn (push-mark (point) t t)
	     (funcall movement-function))
    (funcall movement-function)))


(use-package doro-basic
  :bind
  (:map doro-mode-map
	("M-i" . previous-line)
	("M-I" . doro-previous-line-mark)
	("M-k" . next-line)
	("M-K" . doro-next-line-mark)

	("M-j" . backward-char)
	("M-J" . doro-backward-char-mark)
	("M-l" . forward-char)
	("M-L" . doro-forward-char-mark)

	("M-q" . beginning-of-line)
	("M-Q" . doro-beginning-of-line-mark)
	("M-a" . end-of-line)
	("M-A" . doro-end-of-line-mark)

	("M-," . beginning-of-buffer)
	("M-<" . doro-beginning-of-buffer-mark)
	("M-." . end-of-buffer)
	("M->" . doro-end-of-buffer-mark)

	)

  :init

  (defun doro-previous-line-mark ()
    (interactive)
    (doro-mark #'previous-line))

  (defun doro-next-line-mark ()
    (interactive)
    (doro-mark #'next-line))

  (defun doro-backward-char-mark ()
    (interactive)
    (doro-mark #'backward-char))

  (defun doro-forward-char-mark ()
    (interactive)
    (doro-mark #'forward-char))

  (defun doro-beginning-of-line-mark ()
    (interactive)
    (doro-mark #'beginning-of-line))

  (defun doro-end-of-line-mark ()
    (interactive)
    (doro-mark #'end-of-line))

  (defun doro-beginning-of-buffer-mark ()
    (interactive)
    (doro-mark #'beginning-of-buffer))

  (defun doro-end-of-buffer-mark ()
    (interactive)
    (doro-mark #'end-of-buffer))
  )


(use-package doro-word
  :bind
  (:map doro-mode-map
	("M-u" . doro-word-backward)
	("M-U" . doro-word-backward-mark)
	("M-o" . doro-word-forward)
	("M-O" . doro-word-forward-mark)
	("M-DEL" . doro-delete-word-backward)
	("M-<delete>" . doro-delete-word-forward)
	)

  :init
  
  (defun doro-word-comprehend-backward (char-function)
    "passed function processes words consisting only of alphabetic characters"
    (let ((case-fold-search nil))
      (cond ((looking-back "[^[:alpha:]]\\|[A-Z]\\|[А-Я]") (funcall char-function))
	    ((while (looking-back "[a-z]\\|[а-я]") (funcall char-function)))
	    ((looking-back "[A-Z]\\|[А-Я]") (funcall char-function)))))

  (defun doro-word-comprehend-forward (char-function)
    "passed function processes words consisting only of alphabetic characters"
    (let ((case-fold-search nil))
      (cond ((looking-at "[^[:alpha:]]") (funcall char-function))
  	    ((looking-at "[A-Z]\\|[А-Я]\\|[a-z]\\|[а-я]") (funcall char-function)
  	     (while (looking-at "[a-z]\\|[а-я]") (funcall char-function))))))

  (defun doro-word-backward ()
    (interactive)
    (doro-word-comprehend-backward #'backward-char))

  (defun doro-word-forward ()
    (interactive)
    (doro-word-comprehend-forward #'forward-char))

  (defun doro-delete-word-backward ()
    (interactive)
    (doro-word-comprehend-backward (lambda () (delete-backward-char 1))))

  (defun doro-delete-word-forward ()
    (interactive)
    (doro-word-comprehend-forward (lambda () (delete-forward-char 1))))

  (defun doro-word-backward-mark ()
    (interactive)
    (doro-mark #'doro-word-backward))

  (defun doro-word-forward-mark ()
    (interactive)
    (doro-mark #'doro-word-forward))

  )
