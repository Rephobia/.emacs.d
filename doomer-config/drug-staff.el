(use-package drag-stuff
  
  ;; https://github.com/rejeep/drag-stuff.el
  
  :ensure t
  
  :bind
  
  (:map doomer/keymap
	("M-p" . doomer/toggle-active-drag-mode)
	)
  (:map doomer/drag-mode-map
	("C-g" . doomer/drag-keyboard-quit)
	([remap previous-line] . drag-stuff-up)
	([remap next-line] . drag-stuff-down)
	)
  
  :init
  
  (defvar doomer/drag-mode-map (make-sparse-keymap)
    "Keymap while doomer/drag-mode is active. 
Goal of the keymap is to rebind C-g to conclude dragging.")

  (define-minor-mode doomer/drag-mode
    "Mode while dragging is active."
    :init-value nil
    doomer/drag-mode-map)
  
  (defun doomer/drag-keyboard-quit ()
    "Deactivate mark and exit doomer/drag-mode."
    (interactive)
    (doomer/drag-mode 0)
    (deactivate-mark))

  (defun doomer/turn-on-drag-mode ()
    (interactive)
    (doomer/drag-mode t))

  (defun doomer/turn-off-drag-mode ()
    (interactive)
    (doomer/drag-mode -1))
  
  (defun doomer/toggle-active-drag-mode ()
    (interactive)
    (if (bound-and-true-p doomer/drag-mode)
	(doomer/drag-keyboard-quit)
      (doomer/turn-on-drag-mode)
      )
    )
  
  )
