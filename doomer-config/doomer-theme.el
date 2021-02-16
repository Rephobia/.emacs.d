(deftheme doomer-theme)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode 2)

(blink-cursor-mode 0)
(line-number-mode t)
(column-number-mode t)
(global-hl-line-mode t)

;; Fonts
;; 1liI|0Oo
(set-frame-font "consolas-11")
;; (set-default-font "Liberation Mono 10")
;; (set-default-font "Hack 10")
;; (set-default-font "Terminus-11")
;; (set-default-font "Liberation-11")
;; (set-default-font "DejaVu Sans Mono-10")
;; (set-default-font "Anonymous Pro 11")

(let ((custom--inhibit-theme-enable nil)
      (tan "#d2b48c")
      (white "#ffffff")
      (gray-0 "#525252")
      (gray-1 "#828282")
      (gray-2 "#999999")
      (black-0 "#000000")
      (black-1 "#242424")
      (fuchsia "#ff00ff")
      (hot-pink "#ff69b4")
      (sea-green "#2e8b57")
      (aluminium "#272b2e")
      (tango-plum "#5c3566")  
      (tango-orange "#f57900")
      (yellow-green "#9acd32")
      (deep-sky-blye "#00bfff")
      (tango-aluminium "#2e3436")
      (tango-sky-blue-0 "#3465a4")
      (tango-sky-blue-1 "#729fcf")
      (tango-chameleon-0 "#4e9a06")
      (tango-chameleon-1 "#73d216")
      (tango-chameleon-2 "#8ae234")
      (tango-scarlet-red "#a40000")
      )

  (custom-theme-set-faces
   'doomer-theme
   `(default ((t (:background ,tango-aluminium :foreground ,gray-1))))
   `(fringe  ((t (:background ,tango-aluminium))))
   `(hl-line ((t (:background ,black-1))))
   `(cursor  ((t (:background ,tango-scarlet-red))))
   `(region  ((t (:background ,tango-sky-blue-0))))
   `(highlight ((t (:background ,black-1))))

   `(show-paren-match ((t (:background nil :foreground ,fuchsia))))
   `(mode-line ((t (:background ,black-1 :foreground ,gray-2))))
   `(mode-line-inactive ((t (:background ,black-1 :foreground ,gray-0))))

   `(mc/cursor-face   ((t (:background ,tango-scarlet-red))))

   `(ivy-current-match ((t (:background ,black-1))))
   `(ivy-subdir ((t (:foreground ,deep-sky-blye))))
   `(ivy-virtual ((t (:foreground ,deep-sky-blye))))
   `(minibuffer-prompt ((t (:background ,deep-sky-blye :foreground ,black-1 :weight bold))))
   `(ivy-minibuffer-match-face-1 ((t (:foreground ,gray-1))))
   `(ivy-minibuffer-match-face-2 ((t (:foreground ,white))))
   `(ivy-minibuffer-match-face-3 ((t (:foreground ,white))))
   `(ivy-minibuffer-match-face-4 ((t (:foreground ,white))))

   `(avy-goto-char-timer-face ((t (:foreground ,tango-chameleon-2))))
   `(avy-lead-face   ((t (:foreground ,tango-chameleon-1))))
   `(avy-lead-face-0 ((t (:foreground ,tango-chameleon-1))))
   `(avy-lead-face-1 ((t (:foreground ,tango-chameleon-0))))

   `(aw-leading-char-face ((t (:foreground ,tango-chameleon-1))))

   `(iedit-occurrence ((t (:background ,tango-plum))))
   `(vhl/default-face ((t (:background ,tango-plum))))

   `(font-lock-preprocessor-face	((t (:foreground ,gray-0))))
   `(font-lock-comment-face		((t (:foreground ,gray-0))))
   `(font-lock-keyword-face		((t (:foreground ,tango-sky-blue-1))))
   `(font-lock-string-face		((t (:foreground ,sea-green))))
   `(font-lock-variable-name-face	((t (:foreground ,tango-orange))))
   `(font-lock-function-name-face	((t (:foreground ,hot-pink))))
   `(font-lock-type-face		((t (:foreground ,tan))))
   `(font-lock-constant-face		((t (:foreground ,yellow-green))))
   `(font-lock-warning-face		((t (:foreground ,tango-scarlet-red :weight bold))))
   `(link				((t (:foreground ,sea-green :underline t))))

   `(company-tooltip				((t (:background ,aluminium))))
   `(company-tooltip-common			((t (:foreground ,white))))
   `(company-tooltip-selection			((t (:background ,black-1))))
   `(company-tooltip-annotation			((t (:foreground ,gray-0))))
   `(company-tooltip-annotation-selection	((t (:foreground ,gray-0))))
   `(company-preview-common			((t (:background ,black-0 :underline t))))
   `(company-scrollbar-fg			((t (:background ,black-0))))
   `(company-scrollbar-bg			((t (:background ,gray-0))))

   `(js2-function-param ((t (:foreground ,tango-orange))))
   )
  )

(setq-default mode-line-format
              (list "-"
		    'mode-line-mule-info
		    'mode-line-modified
		    'mode-line-frame-identification
		    '(which-func-mode ("" which-func-format "--"))
		    '(line-number-mode "%l/")
		    '(column-number-mode "%c/")
		    '(-3 "%p")
		    "    %b    "
		    '(vc-mode vc-mode)
		    "    "
		    (getenv "HOST")
		    'mode-line-modes
		    ))

(delight '((abbrev-mode nil abbrev)
	   (smart-tab-mode " \\t" smart-tab)
	   (eldoc-mode nil "eldoc")
	   (overwrite-mode " Ov" t)
	   ))

(provide-theme 'doomer-theme)
