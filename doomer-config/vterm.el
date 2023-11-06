(use-package vterm
  :ensure t
  :bind
  (:map vterm-mode-map
	([remap previous-line] . [up])
	([remap next-line] . [down])
	([remap backward-char] . [left])
	([remap forward-char] . [right])
	([remap doomer/word-backward] . [M-left])
	([remap doomer/word-forward] . [M-right])
	([remap doomer/word-backward-mark] . [M-left])
	([remap doomer/word-forward-mark] . [M-right])
	([remap beginning-of-line] . [home])
	([remap end-of-line] . [end])
	([remap doomer/delete] . doomer/vterm-delete-line)
	([remap doomer/delete-word-forward] . [delete])
	([remap doomer/org-todo-with-sort] . vterm-copy-mode)
	)
  (:map vterm-copy-mode-map
	([remap vterm-end-of-line] . doomer/copy)
	)
  :config
  (defun doomer/vterm-delete-line ()
    (interactive)
    (vterm-send "<end>")
    (vterm-send-key "u" t nil t)
    )
  :hook ((vterm-mode . (lambda () (setq-local global-hl-line-mode nil)))
	 (vterm-copy-mode . (lambda () (call-interactively 'hl-line-mode)))
	 )
  )
