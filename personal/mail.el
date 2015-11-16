(setq gnus-select-method
      '(nntp "localhost")) ; I also read news in gnus; it is copied to my local machine via **leafnode**

(setq gnus-secondary-select-methods
      '((nnmaildir "GMail" (directory "~/Maildir/Gmail")) ; grab mail from here
    (nnfolder "archive"
      (nnfolder-directory   "~/Documents/gnus/Mail/archive") ; where I archive sent email
      (nnfolder-active-file "~/Documents/gnus/Mail/archive/active")
      (nnfolder-get-new-mail nil)
      (nnfolder-inhibit-expiry t))))
