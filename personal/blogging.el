(defun wrap-in-quotes (s) (format "\"%s\"" s))

(defun create-new-blog-post (title categories slug)
  "Creates a new jekyll blog post. Assumes a lot about the environment."
  (interactive "sPost title: \nsPost categories (uppercased, comma seperated): \nsPost slug (optional, can be guessed from the title): ")
  (let* ((year (format-time-string "%Y"))
         (date (format-time-string "%Y-%m-%d"))
         (cleaned-title (replace-regexp-in-string "[\'_\?]" "" title))
         (cleaned-title (replace-regexp-in-string "&" "and" cleaned-title))
         (downcased-title (downcase cleaned-title))
         (slugged-title (if (not (string= slug ""))
                            slug
                            (replace-regexp-in-string " " "-"
                                                      downcased-title)))
         (filename (concat "~/c/onfrst.com/log0ymxm/blog-2015/_posts/" year "/" date "-" slugged-title ".md"))

         (formatted-categories (mapconcat 'identity
                                          (mapcar 'wrap-in-quotes
                                                  (split-string categories ", "))
                                          ", "))
         (default-content (format "---\ntitle: %s\ncategories: [%s]\nlayout: default\npublished: false\n---\n\nHappy blogging!\n"
                                  title
                                  formatted-categories)))
    (find-file filename)
    (insert default-content)))

(defun publish-blog (message)
  "Commits posts in the blog and runs ansible to publish it. Assumes a ton about the environment."
  (interactive "sCommit message: ")
  (let ((default-directory "~/c/onfrst.com/log0ymxm/blog-2015/"))
    (shell-command "git add .") ;; Careful, you better know what you're committing!!
    (shell-command (format "git commit -m \"%s\""
                           message))
    (shell-command "git push origin master"))
  (eshell)
  (goto-char (point-max))
  (eshell-kill-input))

(autoload 'endless/export-to-blog "jekyll-once")
(setq org-jekyll-use-src-plugin t)

;; Obviously, these two need to be changed for your blog.
(setq endless/blog-base-url "http://paul.engl.is/")
(setq endless/blog-dir (expand-file-name "~/c/onfrst.com/log0ymxm/blog-org-test/"))
