;; https://github.com/magnars/multiple-cursors.el


(use-package multiple-cursors
  :ensure t
  
  :init
  (define-key input-decode-map [?\C-m] [C-m])

  (define-key doro-mode-map (kbd "M-m") 'mc/edit-lines)
  (define-key doro-mode-map (kbd "M-M") 'mc/mark-all-dwim)
  (define-key doro-mode-map (kbd "M-C-m") 'mc-hide-unmatched-lines-mode)

  (define-key doro-mode-map (kbd "M-C-i") 'mc/mark-previous-like-this)
  (define-key doro-mode-map (kbd "M-C-k") 'mc/mark-next-like-this)

  (define-key doro-mode-map (kbd "<C-m> i") 'mc/unmark-previous-like-this)
  (define-key doro-mode-map (kbd "<C-m> k") 'mc/unmark-next-like-this)

  :config
  (setq mc/always-run-for-all 1)
  (define-key mc/keymap (kbd "<return>") nil)
  (define-key mc/keymap (kbd "C-v") 'yank)
  (define-key mc/keymap (kbd "C-n") 'mc/insert-numbers)
  (define-key mc/keymap (kbd "C-l") 'mc/insert-letters)
  
  )


