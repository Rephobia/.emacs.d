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
    (org-sort-entries nil ?f 'era/todosort-key-func nil nil)
    )

  (defun era/todosort-key-func ()
    "https://stackoverflow.com/questions/63522981/how-can-i-apply-org-sort-entries-using-a-custom-todo-keyword-order/63841835#63841835"
    (cl-position
     (nth 2 (org-heading-components))
     '(nil "WORK" "TODO" "DONE")
     :test 'equal
     )
    )
  (setq org-todo-keywords
	'((sequence "TODO" "WORK" "|" "DONE")))
  )
