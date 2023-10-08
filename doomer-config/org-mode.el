(use-package org-mode
  :ensure org-plus-contrib
  :mode (("\\.org$" . org-mode))

  :bind
  (:map doomer/keymap
	("C-c C-t" . era/org-todo-with-sort)
	)
  :init
  (defun era/org-todo-with-sort ()
    (interactive)
    (org-todo)
    (mark-whole-buffer)
    (org-sort-entries nil ?o nil nil nil)
    )
  )
