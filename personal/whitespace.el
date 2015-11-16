(defun gf/indent-buffer ()
  "Indent the entire buffer."
  (interactive)
  (indent-region (point-min) (point-max)))

(defun gf/indent-cleanup-buffer ()
  "Indent and cleanup the whitespace of the entire buffer."
  (interactive)
  (gf/indent-buffer)
  (ethan-wspace-clean-all))

(define-key evil-normal-state-map ",=" 'gf/indent-buffer)
(define-key evil-normal-state-map ",+" 'gf/indent-cleanup-buffer)

;; Unfortunately some file types use tabs. Tell ethan-wspace to go
;; easy on them.
(defun tabs-are-less-evil ()
  (setq ethan-wspace-errors (remove 'tabs ethan-wspace-errors)))

(add-hook 'makefile-mode-hook 'tabs-are-less-evil)
(add-hook 'git-commit-hook 'tabs-are-less-evil)

;; Change to unix line endings when loading a DOS file
;; http://www.emacswiki.org/emacs/DosToUnix

(defun dos2unix ()
  "Not exactly but it's easier to remember"
  (interactive)
  (set-buffer-file-coding-system 'unix 't))

(define-key evil-normal-state-map ",,+" 'dos2unix)
