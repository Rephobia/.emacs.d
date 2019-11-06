;; https://github.com/abo-abo/ace-window


(use-package doomer-window
  :bind
  (:map doomer-mode-map
	("C-q" . doomer-scroll-half-page-down)
	("C-a" . doomer-scroll-half-page-up)
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

  (defun doomer-scroll-half-page-down ()
    (interactive)
    "scroll down half the page"
    (scroll-down (- (/ (window-body-height) 2) 1)))

  (defun doomer-scroll-half-page-up ()
    (interactive)
    "scroll up half the page"
    (scroll-up (- (/ (window-body-height) 2) 1)))

  )


(use-package ace-window
  :ensure t
  
  :bind
  (:map doomer-mode-map
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
	  (?c doomer-kill-compilation-buf)

	  (?s aw-swap-window "Ace - Swap Window")
	  (?1 doomer-split-focus-window-v)
	  (?2 doomer-split-focus-window-h)
	  (?b balance-windows)
	  ))

  (defun doomer-split-focus-window-h ()
    (split-window-horizontally)
    (other-window 1))

  (defun doomer-split-focus-window-v ()
    (split-window-vertically)
    (other-window 1))

  (defun doomer-kill-compilation-buf ()
    (kill-buffer "*compilation*"))

  )
