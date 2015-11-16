(prelude-require-packages '(magit))

(require 'magit)

(defun magit-toggle-whitespace ()
  (interactive)
  (if (member "-w" magit-diff-options)
      (magit-dont-ignore-whitespace)
    (magit-ignore-whitespace)))

(defun magit-ignore-whitespace ()
  (interactive)
  (add-to-list 'magit-diff-options "-w")
  (magit-refresh))

(defun magit-dont-ignore-whitespace ()
  (interactive)
  (setq magit-diff-options (remove "-w" magit-diff-options))
  (magit-refresh))

(define-key magit-status-mode-map (kbd "W") 'magit-toggle-whitespace)

(define-key magit-status-mode-map (kbd "K") 'magit-discard)

(setq
 ;; open magit status in same window as current buffer
 magit-status-buffer-switch-function 'switch-to-buffer
 ;; highlight word/letter changes in hunk diffs
 magit-diff-refine-hunk t
 ;; pop the process buffer if we're taking a while to complete
 magit-process-popup-time 10
 ;; ask me if I want a tracking upstream
 magit-set-upstream-on-push 'askifnotset)
