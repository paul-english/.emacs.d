(prelude-require-packages '(window-numbering
                            flatland-theme
                            ag
                            evil-leader
                            evil-surround
                            string-inflection
                            web-mode))

;; Window numbering
(require 'window-numbering)
(window-numbering-mode 1)

(global-set-key (kbd "s-0") 'select-window-0)
(global-set-key (kbd "s-1") 'select-window-1)
(global-set-key (kbd "s-2") 'select-window-2)
(global-set-key (kbd "s-3") 'select-window-3)
(global-set-key (kbd "s-4") 'select-window-4)
(global-set-key (kbd "s-5") 'select-window-5)
(global-set-key (kbd "s-6") 'select-window-6)
(global-set-key (kbd "s-7") 'select-window-7)
(global-set-key (kbd "s-8") 'select-window-8)
(global-set-key (kbd "s-9") 'select-window-9)

;; Theme
(load-theme 'flatland)

;; Hotkeys
(global-set-key (kbd "s-;") 'comment-dwim)
(global-set-key (kbd "s-/") 'comment-dwim)
(global-set-key (kbd "s-t") 'projectile-find-file)
(global-set-key (kbd "s-B") 'projectile-recentf)
(global-set-key (kbd "s-b") 'ido-switch-buffer)

;; Emacs server
(require 'server)
(unless (server-running-p)
  (server-start))
;;(setq server-socket-dir "~/.emacs.d/server")

;;Allows launching from chrome textareas
;; TODO
;; (require 'edit-server nil t)
;; (unless (process-status "edit-server")
;;   (setq edit-server-new-frame t)
;;   (edit-server-start))

;; (require 'setup-flyspell)


;; Set the same path as terminal
(setenv "PATH" (shell-command-to-string "zsh -i -c 'echo -n $PATH'"))

;; Highlight merge conflicts
(defun sm-try-smerge ()
  (save-excursion
    (goto-char (point-min))
    (when (re-search-forward "^<<<<<<< " nil t)
      (smerge-mode 1))))

(add-hook 'find-file-hook 'sm-try-smerge)

;; Automatically create directories when creating a file
(defadvice find-file (before make-directory-maybe (filename &optional wildcards) activate)
  "Create parent directory if not exists while visiting file."
  (unless (file-exists-p filename)
    (let ((dir (file-name-directory filename)))
      (unless (file-exists-p dir)
        (make-directory dir)))))

;; Load ssh credentials from keychain, even if keychain was called
;; after emacs startup
;; TODO
;(require 'keychain-environment)
;; (define-key evil-normal-state-map ",k" (lambda ()
;;                                          (interactive)
;;                                          (keychain-refresh-environment)
;;                                          (message "Keychain environment refreshed.")))

;; refresh the current major mode
(define-key global-map (kbd "<f6>") (lambda ()
                                      (interactive)
                                      (call-interactively major-mode)))

(autoload 'try-code "try-code"  nil t)
(global-set-key (kbd "C-?") 'try-code)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(setq web-mode-content-types-alist
      '(("jsx" . "\\.js\\'")))

(global-set-key (kbd "C-;") 'universal-argument)

(add-to-list 'auto-mode-alist '("\\.ledger$" . ledger-mode))

(setq magit-last-seen-setup-instructions "1.4.0")

(defun save-buffer-always ()
  "Save the buffer even if it is not modified."
  (interactive)
  (set-buffer-modified-p t)
  (save-buffer))

(define-key global-map (kbd "C-x C-s") 'save-buffer-always)
