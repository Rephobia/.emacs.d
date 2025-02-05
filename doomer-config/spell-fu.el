(use-package spell-fu
  :ensure t
  :config
  (setq ispell-program-name "aspell")
  (setq spell-fu-ignore-modes '(org-mode dired-mode vterm-mode)) ;; Моды в которых мне не нужна проверка грамматики
  (add-hook 'spell-fu-mode-hook
            (lambda ()
              (spell-fu-dictionary-add (spell-fu-get-ispell-dictionary "en"))
              (spell-fu-dictionary-add (spell-fu-get-ispell-dictionary "ru"))))

  (defun cs/spell-fu-check-range (pos-beg pos-end)
    (let (case-fold-search)
      (spell-fu-check-range-default pos-beg pos-end)))

  (setq-default spell-fu-check-range #'cs/spell-fu-check-range)
  )
