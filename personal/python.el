;;(prelude-require-packages '(jedi))

;; iPython Tab Completion
;; (setq
;;  python-shell-interpreter "/Users/nrub/.virtualenvs/urop/bin/ipython"
;;  python-shell-interpreter-args ""
;;  python-shell-prompt-regexp "In \\[[0-9]+\\]: "
;;  python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
;;  python-shell-completion-setup-code "from IPython.core.completerlib import module_completion"
;;  python-shell-completion-module-string-code "';'.join(module_completion('''%s'''))\n"
;;  python-shell-completion-string-code "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;; Python fix spaces when slurping sexp with parens
;; https://github.com/Fuco1/smartparens/issues/236
(sp-local-pair 'python-mode
               "(" nil
               :pre-handlers '(sp-python-pre-slurp-handler))

(defun sp-python-pre-slurp-handler (id action context)
  (when (eq action 'slurp-forward)
    ;; if there was no space before, there shouldn't be after either
    ;; ok = enclosing, next-thing one being slurped into
    (save-excursion
      (when (and (= (sp-get ok :end) (sp-get next-thing :beg))
                 (equal (sp-get ok :op) (sp-get next-thing :op)))
        (goto-char (sp-get ok :end))
        (when (looking-back " ")
          (delete-char -1))))))

(add-hook 'python-mode 'hs-minor-mode)

;; (add-hook 'python-mode-hook 'jedi:setup)
;; (setq jedi:complete-on-dot t)

;; Quick fix: anaconda sentinal server error
;; https://github.com/proofit404/anaconda-mode/issues/106
;; https://github.com/proofit404/anaconda-mode/issues/114
;; (setq anaconda-mode-server-script "/usr/local/lib/python2.7/site-packages/anaconda_mode.py")
