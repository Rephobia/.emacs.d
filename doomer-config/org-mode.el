(use-package org-mode
  :ensure org-contrib
  :mode (("\\.org$" . org-mode))

  :bind
  (:map doomer/keymap
	("C-c C-t" . doomer/org-todo-with-sort)
	("C-c C-a" . (lambda () (interactive) (org-agenda nil "t")))
	("C-c C-A" . org-archive-subtree)
	)
  :init
  (defun doomer/org-todo-with-sort ()
    (interactive)
    (org-todo)
    (save-excursion
      (mark-whole-buffer)
      (org-sort-entries nil ?f 'doomer/todosort-key-func nil nil)
      )
    )

  (defun doomer/todosort-key-func ()
    "https://stackoverflow.com/questions/63522981/how-can-i-apply-org-sort-entries-using-a-custom-todo-keyword-order/63841835#63841835"
    (cl-position
     (nth 2 (org-heading-components))
     '(nil "WORK" "TODO" "DONE")
     :test 'equal
     )
    )

  (setq org-todo-keywords
	'((sequence "TODO" "WORK" "|" "DONE")))

  (setq org-agenda-files '("~/todo"))

  (setq org-archive-location "~/todo/archive/%s_archive::")

  (setq org-agenda-window-setup 'only-window)

  (setq org-startup-folded nil)

  (setq org-agenda-archives-mode t)
  )

(use-package org-download
  :ensure t
  )
