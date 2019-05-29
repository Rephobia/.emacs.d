
(defun linhurdos-mark (movement-function)
  (if (not (use-region-p))
      (progn (push-mark (point) t t)
	     (funcall movement-function))
    (funcall movement-function)))


(use-package linhurdos-basic
  :bind
  (:map linhurdos-mode-map
	("M-i" . previous-line)
	("M-I" . linhurdos-previous-line-mark)
	("M-k" . next-line)
	("M-K" . linhurdos-next-line-mark)

	("M-j" . backward-char)
	("M-J" . linhurdos-backward-char-mark)
	("M-l" . forward-char)
	("M-L" . linhurdos-forward-char-mark)

	("M-q" . beginning-of-line)
	("M-Q" . linhurdos-beginning-of-line-mark)
	("M-a" . end-of-line)
	("M-A" . linhurdos-end-of-line-mark)

	("M-," . beginning-of-buffer)
	("M-<" . linhurdos-beginning-of-buffer-mark)
	("M-." . end-of-buffer)
	("M->" . linhurdos-end-of-buffer-mark)

	)

  :init

  (defun linhurdos-previous-line-mark ()
    (interactive)
    (linhurdos-mark #'previous-line))

  (defun linhurdos-next-line-mark ()
    (interactive)
    (linhurdos-mark #'next-line))

  (defun linhurdos-backward-char-mark ()
    (interactive)
    (linhurdos-mark #'backward-char))

  (defun linhurdos-forward-char-mark ()
    (interactive)
    (linhurdos-mark #'forward-char))

  (defun linhurdos-beginning-of-line-mark ()
    (interactive)
    (linhurdos-mark #'beginning-of-line))

  (defun linhurdos-end-of-line-mark ()
    (interactive)
    (linhurdos-mark #'end-of-line))

  (defun linhurdos-beginning-of-buffer-mark ()
    (interactive)
    (linhurdos-mark #'beginning-of-buffer))

  (defun linhurdos-end-of-buffer-mark ()
    (interactive)
    (linhurdos-mark #'end-of-buffer))
  )


(use-package linhurdos-word
  :bind
  (:map linhurdos-mode-map
	("M-u" . linhurdos-word-backward)
	("M-U" . linhurdos-word-backward-mark)
	("M-o" . linhurdos-word-forward)
	("M-O" . linhurdos-word-forward-mark)
	("M-DEL" . linhurdos-delete-word-backward)
	("M-<delete>" . linhurdos-delete-word-forward)
	)

  :init
  
  (defun linhurdos-word-comprehend-backward (char-function)
    "passed function processes words consisting only of alphabetic characters"
    (let ((case-fold-search nil))
      (cond ((looking-back "[^[:alpha:]]\\|[A-Z]\\|[А-Я]") (funcall char-function))
	    ((while (looking-back "[a-z]\\|[а-я]") (funcall char-function)))
	    ((looking-back "[A-Z]\\|[А-Я]") (funcall char-function)))))

  (defun linhurdos-word-comprehend-forward (char-function)
    "passed function processes words consisting only of alphabetic characters"
    (let ((case-fold-search nil))
      (cond ((looking-at "[^[:alpha:]]") (funcall char-function))
  	    ((looking-at "[A-Z]\\|[А-Я]\\|[a-z]\\|[а-я]") (funcall char-function)
  	     (while (looking-at "[a-z]\\|[а-я]") (funcall char-function))))))

  (defun linhurdos-word-backward ()
    (interactive)
    (linhurdos-word-comprehend-backward #'backward-char))

  (defun linhurdos-word-forward ()
    (interactive)
    (linhurdos-word-comprehend-forward #'forward-char))

  (defun linhurdos-delete-word-backward ()
    (interactive)
    (linhurdos-word-comprehend-backward (lambda () (delete-backward-char 1))))

  (defun linhurdos-delete-word-forward ()
    (interactive)
    (linhurdos-word-comprehend-forward (lambda () (delete-forward-char 1))))

  (defun linhurdos-word-backward-mark ()
    (interactive)
    (linhurdos-mark #'linhurdos-word-backward))

  (defun linhurdos-word-forward-mark ()
    (interactive)
    (linhurdos-mark #'linhurdos-word-forward))

  )
