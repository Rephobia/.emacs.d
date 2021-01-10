(use-package ace-window

  ;; https://github.com/abo-abo/ace-window
  
  :ensure t
  
  :bind
  (:map doomer/keymap
	("M-3" . ace-window)
	)

  :config
  
  (setq aw-keys '(?q ?w ?e ?r)
	aw-background t
	aw-dispatch-always t
	aw-dispatch-alist
	'((?d delete-window)
	  (?D delete-other-windows)

	  (?x bury-buffer)
	  (?k kill-this-buffer)
	  (?K kill-buffer-and-window)
	  (?c doomer/kill-compilation-buf)

	  (?s aw-swap-window "Ace - Swap Window")
	  (?v doomer/split-focus-window-v)
	  (?h doomer/split-focus-window-h)
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
