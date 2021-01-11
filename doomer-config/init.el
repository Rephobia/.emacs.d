;; Hotkey RUS
(defun cfg:reverse-input-method (input-method)
  "Build the reverse mapping of single letters from INPUT-METHOD."
  (interactive
   (list (read-input-method-name "Use input method (default current): ")))
  (if (and input-method (symbolp input-method))
      (setq input-method (symbol-name input-method)))
  (let ((current current-input-method)
        (modifiers '(nil (control) (meta) (control meta))))
    (when input-method
      (activate-input-method input-method))
    (when (and current-input-method quail-keyboard-layout)
      (dolist (map (cdr (quail-map)))
        (let* ((to (car map))
               (from (quail-get-translation
                      (cadr map) (char-to-string to) 1)))
          (when (and (characterp from) (characterp to))
            (dolist (mod modifiers)
              (define-key local-function-key-map
                (vector (append mod (list from)))
                (vector (append mod (list to)))))))))
    (when input-method
      (activate-input-method current))))

;; auto install package
;; =============================================================================

(require 'cl)
(require 'package)

(add-to-list 'package-archives
             '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(package-initialize)

;; behavior
;; ============================================================================

(defalias 'yes-or-no-p 'y-or-n-p)

(setq help-window-select t)

(setq next-screen-context-lines 0)
;;(global-undo-tree-mode)
(transient-mark-mode t)
(electric-pair-mode t)
(setq show-trailing-whitespace t)

(setq require-final-newline    t)       
(setq require-final-newline    t)       
(setq next-line-add-newlines nil)

(delete-selection-mode t)

(setq scroll-step 1)
(setq scroll-margin 0)
(setq scroll-conservatively 10000)

(setq redisplay-dont-pause t)
(setq echo-keystrokes 0.001)

(defadvice compile (after jump-back activate)
  (switch-to-buffer-other-window "*compilation*"))

(show-paren-mode t)
(setq show-paren-style 'parenthesis)

;; Backup
;; ============================================================================

(setq auto-save-interval 512)
(setq auto-save-timeout 10)
(setq backup-directory-alist        
      '((".*" . "~/backups/emacs")))
(setq backup-by-copying t)
(setq version-control t)
(setq delete-old-versions t)
(setq kept-new-versions 6)
(setq kept-old-versions 2)


;; use-package
;; ============================================================================

(unless (package-installed-p 'use-package)
  (message "EMACS install use-package.el")
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(require 'use-package)

(use-package delight
  :ensure t)

(require 'subr-x)

;; user mode
;; ============================================================================

(defvar doomer/keymap (make-sparse-keymap)
  "Global key map for doomer mode.
This keymap allows you to set keybindings,
that won't be remapped third party packages.")

(define-minor-mode doomer-mode
  "Doomer minor mode. It uses doomer/keymap"
  :init-value t
  :keymap doomer/keymap)

(defun turn-on-doomer-mode ()
  (interactive)
  (doomer-mode t))

(defun turn-off-doomer-mode ()
  (interactive)
  (doomer-mode -1))


;; Load options
;; ============================================================================

(load "~/.emacs.d/doomer-config/core-keys")
(load "~/.emacs.d/doomer-config/text-edit")
(load "~/.emacs.d/doomer-config/kill-copy-delete")
(load "~/.emacs.d/doomer-config/comment")
(load "~/.emacs.d/doomer-config/register")

;; language modes
(load "~/.emacs.d/doomer-config/php-mode")
(load "~/.emacs.d/doomer-config/js-mode")

;; third-party packages

(load "~/.emacs.d/doomer-config/dump-jump")
(load "~/.emacs.d/doomer-config/org-mode")
(load "~/.emacs.d/doomer-config/company")
(load "~/.emacs.d/doomer-config/projectile")
(load "~/.emacs.d/doomer-config/volatile-highlights")
(load "~/.emacs.d/doomer-config/undo-tree")
(load "~/.emacs.d/doomer-config/multiple-cursors")
(load "~/.emacs.d/doomer-config/iedit")
(load "~/.emacs.d/doomer-config/drug-staff")
(load "~/.emacs.d/doomer-config/dired")
(load "~/.emacs.d/doomer-config/expand-region")
(load "~/.emacs.d/doomer-config/ace-window")
(load "~/.emacs.d/doomer-config/avy")
(load "~/.emacs.d/doomer-config/minibuffer")
(load "~/.emacs.d/doomer-config/smart-tabs")
(load "~/.emacs.d/doomer-config/yasnippet")

(load "~/.emacs.d/doomer-config/doomer-theme")

(global-undo-tree-mode)

;; RUS Hotkey
(cfg:reverse-input-method 'russian-computer)
