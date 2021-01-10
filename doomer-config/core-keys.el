
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


(use-package shell
  :bind
  (:map minibuffer-local-shell-command-map
	([remap previous-line] . previous-history-element)
	([remap next-line] . next-history-element)
	)
  (:map shell-mode-map
	([remap previous-line] . comint-previous-input)
	([remap next-line] . comint-next-input)	       
	)
  :init
  (push (cons "\\*shell\\*" display-buffer--same-window-action) display-buffer-alist)
  
  )


(use-package eshell-toggle
  
  ;; https://github.com/4da/eshell-toggle
  
  :ensure t
  :custom
  (eshell-toggle-size-fraction 2)
  (eshell-toggle-use-projectile-root t)
  (eshell-toggle-run-command nil)
  (eshell-toggle-init-function #'eshell-toggle-init-ansi-term)

  :bind
  (:map doomer/keymap
	("s-`" . eshell-toggle))

  :init
  
  ;; Override. Eshell-toggle function creates a shell in new window
  
  (eval-after-load "eshell-toggle"
    '(defun eshell-toggle ()
      "Show eshell at the bottom of current window cd to current buffer's path.
If eshell-toggle'd buffer is already visible in frame for current buffer or current window is (toggled) eshell itself then hide it."
      (interactive)
      (if (eq eshell-toggle--toggle-buffer-p t)
	  ;; if we are in eshell-toggle buffer just delete its window
	  (bury-buffer)
	(let ((buf-name (eshell-toggle--make-buffer-name)))
	  (if (get-buffer buf-name)
	      ;; buffer is already created
	      (or (-some-> buf-name eshell-toggle--visiblep delete-window)
		  (switch-to-buffer buf-name))
	    ;; buffer is not created, create it
	    (eshell-toggle--new-buffer buf-name)
	    (switch-to-buffer buf-name)))))    
    )
  )
