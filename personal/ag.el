(prelude-require-packages '(ag))

(require 'ag)

(define-key ag-mode-map (kbd "k") 'evil-previous-line)
