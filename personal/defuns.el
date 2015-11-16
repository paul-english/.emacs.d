(defun gf/comma-to-end-of-sentence ()
  "Change the next comma to a full stop and capitalise the next word."
  (interactive)
  (if (not (looking-at-p ","))
      (evil-find-char 1 (string-to-char ",")))
  (delete-char 1)
  (insert ".")
  (evil-forward-word-begin)
  (evil-upcase (point) (+ 1 (point))))

(defun gf/end-of-sentence-to-comma ()
  "Change the next full stop to a comma and lowercase the next word."
  (interactive)
  (if (not (looking-at-p "\\."))
      (evil-find-char 1 (string-to-char ".")))
  (delete-char 1)
  (insert ",")
  (evil-forward-word-begin)
  (if (not (looking-at-p "I"))
      (evil-downcase (point) (+ 1 (point)))))

(defun gf/open-init-file ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

(defun gf/make-capture-frame ()
  "Make a new frame for using org-capture."
  (interactive)
  (make-frame '((name . "capture") (width . 80) (height . 20)))
  (select-frame-by-name "capture")
  (org-capture))

(defun gf/untabify-line ()
  "Untabify the current line."
  (interactive)
  (untabify (point-at-bol) (point-at-eol)))

(defun gf/untabify-buffer ()
  "Untabify the whole buffer."
  (interactive)
  (untabify (point-min) (point-max)))
