(make-variable-buffer-local 'hippie-expand-try-functions-list)
;(require 'go-mode-load)

(setq auto-mode-alist (cons '("\\.pxi$" . python-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.class$" . hexl-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.xml$" . nxml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cbr$" . archive-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.cbz$" . archive-mode) auto-mode-alist))
;;add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\.groovy$" . groovy-mode))
(add-to-list 'auto-mode-alist '("\\.vm$" . vtl-mode))
(add-to-list 'auto-mode-alist '("\\.txt$" . fundamental-mode))
(add-to-list 'auto-mode-alist '("\\.class$" . hexl-mode))
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.el.gz$" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))
(add-to-list 'auto-mode-alist '("\\.vcl$" . vcl-mode))
(add-to-list 'auto-mode-alist '("\\.ml$" . tuarag-mode))
(add-to-list 'auto-mode-alist '("\\.erl$" . erlang-mode))
(add-to-list 'interpreter-mode-alist '("groovy" . groovy-mode))
(add-to-list 'interpreter-mode-alist '("vcl" . vcl-mode))
;;add-to-list 'auto-mode-alist '("_xml\\.template$" . nxml-mode))

;; Elisp go-to-definition with M-. and back again with M-,
(autoload 'elisp-slime-nav-mode "elisp-slime-nav")
;(eval-after-load 'elisp-slime-nav '(diminish 'elisp-slime-nav-mode))

(add-hook 'lisp-mode-hook (lambdaste (rainbow-delimiters-mode 1)))
(add-hook 'lisp-mode-hook (lambdaste (paredit-mode 1)))
(add-hook 'emacs-lisp-mode-hook (lambdaste (elisp-slime-nav-mode t)))
(add-hook 'emacs-lisp-mode-hook (lambdaste (rainbow-delimiters-mode 1)))
(add-hook 'emacs-lisp-mode-hook (lambdaste (paredit-mode 1)))
(add-hook 'emacs-lisp-mode-hook (lambdaste (setq hippie-expand-try-functions-list
                                                 (append
                                                  (quote (try-complete-lisp-symbol-partially 
                                                          try-complete-lisp-symbol)) 
                                                  hippie-expand-try-functions-list
                                                  ))))

(add-hook 'emacs-lisp-mode-hook (lambdaste (modify-syntax-entry ?- "w")))



;(require 'multi-web-mode)
;(setq mweb-default-major-mode 'html-mode)
;(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
;                  (espresso-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
;                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
;(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
;(multi-web-global-mode 1)

                                        ; slime 

;;; use groovy-mode when file ends in .groovy or has #!/bin/groovy at start
(autoload 'groovy-mode "groovy-mode" "Major mode for editing Groovy code." t)

;; begin groovy
;;; make Groovy mode electric by default.
(add-hook 'groovy-mode-hook
          '(lambda ()
             (require 'groovy-electric)
             (groovy-electric-mode)))

(add-hook 'groovy-mode-hook (lambdaste (linum-mode 1)))

;; end groovy

;;load "/usr/local/share/lush/etc/lush.el")

;; things for different lisps
(require 'slime)

(eval-after-load "slime" 
  '(progn 
     (setq slime-complete-symbol*-fancy t)
     (setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
     (slime-setup '(slime-fancy slime-asdf slime-banner))
))

(defun use-lisp-sbcl ()
  (interactive)
  (setq inferior-lisp-program "/opt/local/bin/sbcl") ; your Lisp system
   (add-to-list 'load-path "~/hack/lisp/slime/")  ; your SLIME directory
   (slime-setup '(slime-fancy)))

;; (defun use-lisp-mitscheme ()
;;   (interactive)
;;   (setq inferior-lisp-program "~/mitscheme/Contents/Resources/mit-scheme") ; your Lisp system
;;   (add-to-list 'load-path "~/hack/lisp/slime/") ; your SLIME directory
;;   (slime-setup '(slime-repl)))
;; (setq slime-lisp-implementations
;;       '((mit-scheme ("~/mitscheme/Contents/Resources/mit-scheme") :init mit-scheme-init)))

;; (defun mit-scheme-init (file encoding)
;;    ;; The `mit-scheme-init' function first loads the SOS and FORMAT
;;    ;; libraries, then creates a package "(swank)", and loads this file
;;    ;; into that package.  Finally it starts the server.  
;;   (format "%S\n\n"
;; 	  `(begin
;; 	    (load-option 'format)
;; 	    (load-option 'sos)
;; 	    (eval 
;; 	     '(construct-normal-package-from-description
;; 	       (make-package-description '(swank) '(()) 
;; 					 (vector) (vector) (vector) false))
;; 	     (->environment '(package)))
;; 	    (load ,(expand-file-name 
;; 		    "/Users/benhsu/.emacs.d/elpa/slime-20120818.1634/contrib/swank-mit-scheme.scm" ; <-- insert your path
;; 		    slime-path)
;; 		  (->environment '(swank)))
;; 	    (eval '(start-swank ,file) (->environment '(swank))))))

;; (defun mit-scheme ()
;;   (interactive)
;;   (slime 'mit-scheme))

;; (defun find-mit-scheme-package ()
;;    ;; `find-mit-scheme-package' tries to figure out which package the
;;    ;; buffer belongs to, assuming that ";;; package: (FOO)" appears
;;    ;; somewhere in the file.  Luckily, this assumption is true for many of
;;    ;; MIT Scheme's own files.  Alternatively, you could add Emacs style
;;    ;; -*- slime-buffer-package: "(FOO)" -*- file variables.
;;   (save-excursion
;;     (let ((case-fold-search t))
;;       (and (re-search-backward "^[;]+ package: \\((.+)\\).*$" nil t)
;; 	   (match-string-no-properties 1)))))

;; (setq slime-find-buffer-package-function 'find-mit-scheme-package)
;; (add-hook 'scheme-mode-hook (lambda () (slime-mode 1)))

;; start with M-x mit-scheme

;; for SICP
;; set scheme-program-name = ~/mitscheme/Contents/Resource/mit-scheme (not working in def custom)
;; use C-x C-e and scheme-expand-form and C-c C-z 'switch-to-scheme

;
;; (setq inferior-lisp-program "/opt/local/bin/scheme48") ; your Lisp system
;
;; (add-to-list 'load-path "~/hack/the-little-schemer/")  ; your SLIME directory
(add-hook 'slime-mode-hook (lambda () (paredit-mode 1)))

;;(defun send-buffer-io ()
;;     (interactive)
;;     (progn
;;          (shell-command-on-region (point-min) (point-max) "Io" "*Messages*")
;;          (switch-to-buffer "io.out")
;;          (goto-char (point-max))
;;          (switch-to-buffer "foo.io")          
;;     ))

;;(local-set-key "\C-x\C-e" 'send-buffer-io)
;; (defun toggle-fullscreen (&optional f)
;;   (interactive)
;;   (let ((current-value (frame-parameter nil 'fullscreen)))
;;     (set-frame-parameter nil 'fullscreen
;;                          (if (equal 'fullboth current-value)
;;                              (if (boundp 'old-fullscreen) old-fullscreen nil)
;;                            (progn (setq old-fullscreen current-value)
;;                                   'fullboth)))))


;; RUBY
(eval-after-load 'ruby-mode
  '(define-key ruby-mode-map (kbd "\C-j") 'ruby-send-last-sexp))
(eval-after-load 'ruby-mode
  '(define-key ruby-mode-map (kbd "{") 'self-insert-command))
(eval-after-load 'ruby-mode
  '(define-key ruby-mode-map (kbd "}") 'self-insert-command))


(defun ruby-send-buffer ()
  "sends the entire buffer to ruby inferior process"
  (interactive)
  (progn
    (ruby-send-region (point-min) (point-max))
    (other-window 1)
    (end-of-buffer)
    (other-window -1)))
;; begin ruby flymake
(require 'flymake)

;; I don't like the default colors :)
(set-face-background 'flymake-errline "red4")
(set-face-background 'flymake-warnline "dark slate blue")

;; Invoke ruby with '-c' to get syntax checking
(defun flymake-ruby-init ()
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (buffer-file-name) ))
    (message local-file)
    (list "ruby" (list "-c" local-file))))

(push '(".+\\.rb$" flymake-ruby-init) flymake-allowed-file-name-masks)
(push '("Rakefile$" flymake-ruby-init) flymake-allowed-file-name-masks)

(push '("^\\(.*\\):\\([0-9]+\\): \\(.*\\)$" 1 2 nil 3) flymake-err-line-patterns)

(add-hook 'ruby-mode-hook
          '(lambda ()
             ;; Don't want flymake mode for ruby regions in rhtml files and also on read only files
             (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
                 (flymake-mode))
             ))

(add-hook 'ruby-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (concat "ruby " buffer-file-name))))


(add-hook 'ruby-mode-hook (lambdaste (linum-mode 1)))

;; ;;; end ruby flymake

;; ;; PYTHON

(require 'python)
 
(setq flymake-python-pyflakes-executable "pyflakes-2.7")

(defvar python-last-buffer nil
  "Name of the Python buffer that last invoked `toggle-between-python-buffers'")
 
(make-variable-buffer-local 'python-last-buffer)
 
(defun toggle-between-python-buffers ()
  "Toggles between a `python-mode' buffer and its inferior Python process
 When invoked from a `python-mode' buffer it will switch the
active buffer to its associated Python process. If the command is
invoked from a Python process, it will switch back to the `python-mode' buffer."
  (interactive)
  ;; check if `major-mode' is `python-mode' and if it is, we check if
  ;; the process referenced in `python-buffer' is running
  (if (and (eq major-mode 'python-mode)
           (processp (get-buffer-process python-buffer)))
      (progn
        ;; store a reference to the current *other* buffer; relying
        ;; on `other-buffer' alone wouldn't be wise as it would never work
        ;; if a user were to switch away from the inferior Python
        ;; process to a buffer that isn't our current one. 
        (switch-to-buffer python-buffer)
        (setq python-last-buffer (other-buffer)))
    ;; switch back to the last `python-mode' buffer, but only if it
    ;; still exists.
    (when (eq major-mode 'inferior-python-mode)
      (if (buffer-live-p python-last-buffer)
           (switch-to-buffer python-last-buffer)
        ;; buffer's dead; clear the variable.
        (setq python-last-buffer nil)))))
 
(define-key inferior-python-mode-map (kbd "<f12>") 'toggle-between-python-buffers)
(define-key python-mode-map (kbd "<f12>") 'toggle-between-python-buffers)

;; for jedi
(autoload 'jedi:setup "jedi" nil t)
;; (setq jedi:setup-keys t)
;; (setq jedi:server-command
;;                   (list "/opt/local/bin/python" )) ;; jedi:server-script

;; (add-hook 'python-mode-hook (lambdaste (flyspell-prog-mode))) this was fucking up my keybind
(add-hook 'python-mode-hook (lambdaste (auto-complete-mode 1)))
(add-hook 'python-mode-hook (lambdaste (linum-mode 1)))
(add-hook 'python-mode-hook (lambdaste (setq indent-tab-modes t)))
(add-hook 'python-mode-hook (lambdaste (setq tab-width 2)))
(add-hook 'python-mode-hook (lambdaste (setq python-indent 2)))

;; (add-hook 'python-mode-hook 'jedi:setup)

;; fixme autopair-dont-pair not working
;; (add-hook 'python-mode-hook (lambdaste (autopair-mode 1)))
;; (add-hook 'python-mode-hook (lambdaste (lambda ()
;;                                          (setq autopair-dont-pair '(:never ((?\" . ?\")))))))


(require 'flymake-python-pyflakes)
(add-hook 'python-mode-hook 'flymake-python-pyflakes-load)

(add-hook 'python-mode-hook
          (lambdaste 
           (define-key 
              python-mode-map 
              (kbd "<return>") 
              (lambda (&optional x) 
                (interactive (list current-prefix-arg))
                (if current-prefix-arg
                    (newline)
                  (newline-and-indent))))))

(defun strip-trailing-whitespace-p (file-name)
  ;; returns t if file-name belongs to a list of suffixes
  (eval (cons 'or (mapcar (lambda (x) (s-ends-with? x (s-downcase file-name))) '("pp" "py" "rb")))))

;; (add-hook 'before-save-hook
;;           (lambdaste 
;;            ;; i am not sure how to run "or" on a list
;;            (if (strip-trailing-whitespace-p (buffer-file-name))
;;                (progn (message "removing trailing whitespace")
;;                       (tabify (point-min) (point-max))
;;                       ;; for some reason \s- doesnt work
;;                       (save-excursion  (replace-regexp "[ \t]+$" "" nil (point-min) (point-max)))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;enable pep8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; To enable pep8 check
;; install pep8 checker with one of those commands
;; sudo apt-get install pep8
;; or
;; sudo pip install pep8

;; (when (load "flymake" t)
;;  (defun flymake-pylint-init ()
;;    (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                       'flymake-create-temp-inplace))
;;           (local-file (file-relative-name
;;                        temp-file
;;                        (file-name-directory buffer-file-name))))
;;          (list "pep8" (list "--repeat" local-file))))

;;  (add-to-list 'flymake-allowed-file-name-masks
;;               '("\\.py\\'" flymake-pylint-init)))

;; (defun my-flymake-show-help ()
;;   (when (get-char-property (point) 'flymake-overlay)
;;     (let ((help (get-char-property (point) 'help-echo)))
;;       (if help (message "%s" help)))))

;; (add-hook 'post-command-hook 'my-flymake-show-help)

;; (custom-set-variables
;;   ...
;;   '(py-pychecker-command "pychecker.sh")
;;   '(py-pychecker-command-args (quote ("")))
;;   '(python-check-command "pychecker.sh")

;; END PYTHON


;; paredit for iELM
;; from http://nullprogram.com/blog/2010/06/10/
(add-hook 'ielm-mode-hook (lambda () (paredit-mode 1)))

;; The function in IELM that spits out the next prompt is ielm-eval-input, so we give it the advice to call the ParEdit function afterwards to insert a parenthesis pair.

;; (defadvice ielm-eval-input (after ielm-paredit activate)
;;   "Begin each IELM prompt with a ParEdit parenthesis pair."
;;   (paredit-open-round))

;; turn on paredit for minibuffer
(add-hook 'minibuffer-setup-hook 'conditionally-enable-paredit-mode)
(defun conditionally-enable-paredit-mode ()
  "enable paredit-mode during eval-expression"
  (if (eq this-command 'eval-expression)
      (paredit-mode 1)))


(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args ""
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
   "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

(require 'info-look)

(info-lookup-add-help
 :mode 'python-mode
 :regexp "[[:alnum:]_]+"
 :doc-spec
 '(("(python)Index" nil "")))


(defun python-symbol-at-point ()
  "Return the start and end points of an python symbol address
   The result is a paired list of character positions for an python symbol address
   located at the current point in the current buffer.  "

  (save-excursion
    (skip-chars-backward "[:alnum:]_.")
    (if (looking-at "[[:alnum:]_.]+")
        (cons (point) (match-end 0)) 
      nil))) ;

(put 'python-symbol 'bounds-of-thing-at-point
     'python-symbol-at-point)

(add-hook 'python-mode-hook
          (lambdaste 
           (define-key 
             python-mode-map 
             (kbd "C-h S") 
             (lambda () 
               (interactive)
               (save-excursion
                 (skip-chars-backward "[:alnum:]_.")
                 (search-forward-regexp "[[:alnum:]_.]+")
                                  (shell-command (format "pydoc %s" (match-string-no-properties 0))))))))

(defun debug-region (start end)
  (interactive "r")
  (progn
    (goto-char start)
    (move-beginning-of-line nil)
    (let ((i (count-lines start end)))
         (while (plusp i)
           (insert (format "print(\"%s\")\n" i) )
           (next-line)
           (decf i)))))

;; move the long list of tables and columns to another file
(load "cm_sql_words.el")

;; set hippie expand for sql
(setq mysql-command-list cm_sql_words)
(defun he-mysql-command-beg ()
      (let ((p))
        (save-excursion
          (backward-word 1)
          (setq p (point)))
        p))
    
(defun try-expand-mysql-command (old)
      (unless old
        (he-init-string (he-mysql-command-beg) (point))
        (setq he-expand-list (sort
                              (all-completions he-search-string (mapcar 'list mysql-command-list))
                              'string-lessp)))
      (while (and he-expand-list
              (he-string-member (car he-expand-list) he-tried-table))
        (setq he-expand-list (cdr he-expand-list)))
      (if (null he-expand-list)
          (progn
            (when old (he-reset-string))
            ())
        (he-substitute-string (car he-expand-list))
        (setq he-tried-table (cons (car he-expand-list) (cdr he-tried-table)))
        (setq he-expand-list (cdr he-expand-list))
        t))

;; horizontal scrolling. turn this on for mysql mode
(setq sql-interactive-mode-hook  nil)
(add-hook 'sql-interactive-mode-hook 
          '(lambda()
             (progn
                 ;; (hscroll-global-mode f)
                 (setq hippie-expand-try-functions-list
                       (append
                        (quote (try-expand-mysql-command
                                )) 
                        hippie-expand-try-functions-list
                        ))
                 (setq hscroll-margin 1)
                 (setq auto-hscroll-mode nil)
                 ;; (setq automatic-hscrolling nil)
                 (modify-syntax-entry ?_ "w")
                 (if (boundp 'truncate-lines)
                     (setq-default truncate-lines t) ; always truncate
                 ))))


(defun sql-make-smart-buffer-name ()
  "Return a string that can be used to rename a SQLi buffer.

This is used to set `sql-alternate-buffer-name' within
`sql-interactive-mode'."
  (or (and (boundp 'sql-name) sql-name)
      (concat (if (not(string= "" sql-server))
                  (concat
                   (or (and (string-match "[0-9.]+" sql-server) sql-server)
                       (car (split-string sql-server "\\.")))
                   "/"))
              sql-database)))

(add-hook 'sql-interactive-mode-hook
          (lambda ()
            (setq sql-alternate-buffer-name (sql-make-smart-buffer-name))
            (sql-rename-buffer)))

(defun sql-connect-preset (name)
  "Connect to a predefined SQL connection listed in `sql-connection-alist'"
  (eval `(let ,(cdr (assoc name sql-connection-alist))
           (flet ((sql-get-login (&rest what)))
             (sql-product-interactive sql-product sql-product)))))

(defun sql-internal()
  (interactive)
  (sql-connect-preset (intern (completing-read "connection name? " sql-connection-alist)))
  )

;; run mysql from local command line, not tramp
(defadvice sql-internal (around make-sql-internal-local activate)
  "Reset to local home, then connect"
  (let ((default-directory "/Users/benhsu"))
    (message default-directory)
    (with-temp-buffer ad-do-it)
    ))

;; horizontal scrolling
;;if (boundp 'truncate-lines)
;;   (setq-default truncate-lines t) ; always truncate
;; (progn
;;   (hscroll-global-mode t)
;;   (setq hscroll-margin 1)
;;   (setq auto-hscroll-mode 1)
;;   (setq automatic-hscrolling t)
;;  ))

(require 'erlang)
(add-hook 'erlang-mode-hook
          (lambdaste 
           (define-key 
             erlang-mode-map 
             (kbd "s-<return>") 'erlang-compile
             )))
(add-hook 'erlang-mode-hook
          (autopair-mode 1))

;; convenience for the sloppy: by default export_all symbols
(setq erlang-compile-extra-opts '(export_all))
