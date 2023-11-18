(defcustom aj8/buffer-skip-regexp
  (rx bos (or (or "*Backtrace*"
		  "*Compile-Log*"
		  "*Completions*"
                  "*Messages*"
		  "*package*"
		  "*GNU Emacs*"
		  "*Warnings*"
		  "*scratch*"
		  "*Quail Completions*"
                  "*Async-native-compile-log*")
              (seq "magit-diff" (zero-or-more anything))
              (seq "magit-process" (zero-or-more anything))
              (seq "magit-revision" (zero-or-more anything))
              (seq "magit-stash" (zero-or-more anything)))
              eos)
  "Regular expression matching buffers ignored by `next-buffer' and
`previous-buffer'."
  :type 'regexp)

(defun aj8/buffer-skip-p (window buffer bury-or-kill)
  "Return t if BUFFER name matches `aj8/buffer-skip-regexp'."
  (string-match-p aj8/buffer-skip-regexp (buffer-name buffer)))

(setq switch-to-prev-buffer-skip 'aj8/buffer-skip-p)

(setq switch-to-prev-buffer-skip-regexp '("\\` " "\\`\\*"))
