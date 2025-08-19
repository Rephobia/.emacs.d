(use-package go-mode
  :ensure t
  :mode "\\.go\\'"
  :hook ((go-mode . lsp-deferred)
         (go-mode . (lambda ()
                      (add-hook 'before-save-hook 'gofmt-before-save nil t)))) ;; автоформатирование
  :config
  (setq gofmt-command "gofmt"))


;; -----------------------
;; Дополнительно (опционально)
;; -----------------------
;; go-tag для работы с struct tags
;; go install github.com/fatih/gomodifytags@latest
(use-package go-tag
  :ensure t
  :after go-mode)
