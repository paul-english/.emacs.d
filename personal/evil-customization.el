(prelude-require-packages '(evil
                            evil-leader
                            evil-surround
                            evil-numbers
                            evil-jumper
                            evil-args
                            evil-exchange))
(require 'evil)

;; Page up hotkey
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-replace-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-motion-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-insert-state-map (kbd "C-u")
  (lambda ()
    (interactive)
    (evil-delete (point-at-bol) (point))))

;; Leader
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "a" 'projectile-ag
  "f" 'projectile-find-file
  "W" 'toggle-frame-split
  "s" 'sort-lines
  "t" 'toggle-truncate-lines
  "n" 'create-new-blog-post
  "p" 'publish-blog
  "h" 'hs-toggle-hiding
  "+" 'hs-show-all
  "-" 'hs-hide-all
  "j" 'dired-jump
  "g" 'magit-status
  "G" 'magit-blame-mode)

(add-hook 'vc-annotate-mode-hook
          (lambda ()
            (evil-define-key 'normal vc-annotate-mode-map "a" 'vc-annotate-revision-previous-to-line)
            (evil-define-key 'normal vc-annotate-mode-map "d" 'vc-annotate-show-diff-revision-at-line)
            (evil-define-key 'normal vc-annotate-mode-map "D" 'vc-annotate-show-changeset-diff-revision-at-line)
            (evil-define-key 'normal vc-annotate-mode-map "f" 'vc-annotate-find-revision-at-line)
            (evil-define-key 'normal vc-annotate-mode-map "J" 'vc-annotate-revision-at-line)
            (evil-define-key 'normal vc-annotate-mode-map "L" 'vc-annotate-show-log-revision-at-line)
            (evil-define-key 'normal vc-annotate-mode-map "n" 'vc-annotate-next-revision)
            (evil-define-key 'normal vc-annotate-mode-map "p" 'vc-annotate-prev-revision)
            (evil-define-key 'normal vc-annotate-mode-map "w" 'vc-annotate-working-revision)
            (evil-define-key 'normal vc-annotate-mode-map "v" 'vc-annotate-toggle-annotation-visibility)))

(require 'evil-numbers)

;; Save point position between sessions
(require 'saveplace)
(setq-default save-place t)

;; Vim style jumplist
(require 'evil-jumper)

;; Centre screen around a search
(defadvice
    evil-search-forward
    (after evil-search-forward-recenter activate)
    (recenter))
(ad-activate 'evil-search-forward)

(defadvice
    evil-search-next
    (after evil-search-next-recenter activate)
    (recenter))
(ad-activate 'evil-search-next)

(defadvice
    evil-search-previous
    (after evil-search-previous-recenter activate)
    (recenter))
(ad-activate 'evil-search-previous)

;; Create lines above and below in normal and insert mode with <return>
(define-key evil-normal-state-map (kbd "S-<return>") (lambda()
                                                       (interactive)
                                                       (evil-open-below 1)
                                                       (evil-normal-state 1)))

(define-key evil-normal-state-map (kbd "C-S-<return>") (lambda()
                                                         (interactive)
                                                         (evil-open-above 1)
                                                         (evil-normal-state 1)))

(define-key evil-insert-state-map (kbd "S-<return>") (lambda()
                                                       (interactive)
                                                       (evil-open-below 1)))

(define-key evil-insert-state-map (kbd "C-S-<return>") (lambda()
                                                         (interactive)
                                                         (evil-open-above 1)))

;; Start in insert mode / emacs for some modes
(add-to-list 'evil-emacs-state-modes 'package-menu-mode)
(evil-set-initial-state 'package-menu-mode 'normal)
(evil-set-initial-state 'org-capture-mode 'insert)
(evil-set-initial-state 'git-commit 'insert)

;; Expand region
(require 'expand-region)
(define-key evil-normal-state-map ",v" 'er/expand-region)

(eval-after-load "evil" '(setq expand-region-contract-fast-key "V"
                               expand-region-reset-fast-key "r"))
(require 'evil-args)

;; bind evil-args text objects
(define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
(define-key evil-outer-text-objects-map "a" 'evil-outer-arg)

;; exchange two regions or motions with gx. gX cancels a pending swap
(require 'evil-exchange)
(evil-exchange-install)

(defun gf/evil-forward-arg (count)
  "Small wrapper around evil-forward-arg when at the opening bracket."
  (interactive "p")
  (if (looking-at-p "(")
      (forward-char))
  (evil-forward-arg count)
  )

;; bind evil-forward/backward-args
(define-key evil-normal-state-map "L" 'gf/evil-forward-arg)
(define-key evil-normal-state-map "H" 'evil-backward-arg)

;; bind evil-jump-out-args
(define-key evil-normal-state-map "K" 'evil-jump-out-args)
