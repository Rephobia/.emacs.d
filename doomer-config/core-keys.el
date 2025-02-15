
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
	("C-x k" . kill-this-buffer)
	("C-x K" . doomer/kill-other-buffers)
	("C-x K" . doomer/kill-other-buffers)
	("C-x F" . rename-current-buffer-file)

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

  (defun doomer/kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer
          (delq (current-buffer)
                (remove-if-not 'buffer-file-name (buffer-list)))))
  
  ;; Source: http://www.whattheemacsd.com/
  (defun rename-current-buffer-file ()
    "Renames current buffer and file it is visiting."
    (interactive)
    (let ((name (buffer-name))
          (filename (buffer-file-name)))
      (if (not (and filename (file-exists-p filename)))
          (error "Buffer '%s' is not visiting a file!" name)
	(let ((new-name (read-file-name "New name: " filename)))
          (if (get-buffer new-name)
              (error "A buffer named '%s' already exists!" new-name)
            (rename-file filename new-name 1)
            (rename-buffer new-name)
            (set-visited-file-name new-name)
            (set-buffer-modified-p nil)
            (message "File '%s' successfully renamed to '%s'."
                     name (file-name-nondirectory new-name)))))))
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
      (cond ((looking-back "[^[:alpha:]]\\|[A-Z]\\|[А-ЯЁ]") (funcall char-function))
            ((while (looking-back "[a-z]\\|[а-яё]") (funcall char-function)))
            ((looking-back "[A-Z]\\|[А-ЯЁ]") (funcall char-function)))))

  (defun doomer/word-comprehend-forward (char-function)
    "passed function processes words consisting only of alphabetic characters"
    (let ((case-fold-search nil))
      (cond ((looking-at "[^[:alpha:]]") (funcall char-function))
             ((looking-at "[A-Z]\\|[А-ЯЁ]\\|[a-z]\\|[а-яё]") (funcall char-function)
             (while (looking-at "[a-z]\\|[а-яё]") (funcall char-function))))))

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
