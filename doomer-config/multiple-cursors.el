(use-package multiple-cursors
  
  ;; https://github.com/magnars/multiple-cursors.el
  
  :ensure t

  :init
  
  (define-key input-decode-map [?\C-m] [C-m])
  (define-key input-decode-map [?\C-i] [C-i])
  
  (define-key doomer/keymap (kbd "M-C-i") 'mc/mark-previous-like-this)
  (define-key doomer/keymap (kbd "M-C-k") 'mc/mark-next-like-this)
  (define-key doomer/keymap (kbd "<C-i>") 'mc/unmark-previous-like-this)
  (define-key doomer/keymap (kbd "C-k" ) 'mc/unmark-next-like-this)
  
  (define-key doomer/keymap (kbd "M-;") 'mc/mark-all-dwim)
  (define-key doomer/keymap (kbd "M-C-;") 'mc-hide-unmatched-lines-mode)
  (define-key doomer/keymap (kbd "M-:") 'mc/edit-lines)
  
  :config
  
  (setq mc/always-run-for-all 1)
  (define-key mc/keymap (kbd "<return>") nil)
  (define-key mc/keymap (kbd "C-v") 'yank)
  (define-key mc/keymap (kbd "C-n") 'mc/insert-numbers)
  (define-key mc/keymap (kbd "C-l") 'mc/insert-letters)

  )
