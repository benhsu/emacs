(defmacro lambdaste (rest) 
  "wraps an form in a lambda so it can be passed to add-hook and define-key"
  `(lambda () ,rest))

;; define-key
;; make-key
;; global-set-key
;; local-set-key

(defmacro make-key (keyseq map command)
  ;; binds keyseq to command in map
  ;; keyseq should look like what you feed to 'kbd', i.e. C-f or s-n
  ;; map should be a keymap, i.e. global-map
  ;; command should be a single command. if more than 1 command progn might work
  ;;
  ;; TODO map should define to global-map
  ;; TODO command should be smart enough to take a symbol or a form
  `(define-key ,map (kbd ,keyseq) (lambda () (interactive) ,command)))


(defun use-this-buffer ()
  (interactive)
  (setq my-buffer (current-buffer)))

(defmacro with-this-buffer (body) (list 'with-current-buffer my-buffer body))

;; bunch of weird code for manipulating cons cells and fp shit. mostly because I like FP
;; from Chris Hungry Man Yacco
(defun sew (victim victims)
  (append victim victims))

(defun following(n l)
  (if (eq n (car l)) (car (cdr l)) (following n (cdr l))))


(defun compose-help (fs x) 
  (cond ((equal fs '()) x) ((equal (cdr fs) '() ) (list (car fs) x)) (t (list (car fs) (compose-help (cdr fs) x)))))

(defmacro compose (fs x) 
  (compose-help fs x))

(defmacro diff (l fx) `(cond ((< (length ,l) 2) (error "fsck"))
                             ((= (length ,l) 2) (,fx (car ,l) (car (cdr ,l))))
                             (t (cons (,fx (car ,l) (car (cdr ,l))) (diff (cdr ,l) ,fx)))))
;; from http://nullprogram.com/blog/2010/11/15/
(defun compose (&rest funs)
  "Return function composed of FUNS."
  (lexical-let ((lex-funs funs))
    (lambda (&rest args)
      (reduce 'funcall (butlast lex-funs)
              :from-end t
              :initial-value (apply (car (last lex-funs)) args)))))

(defmacro loop-over-buffer (rest &rest resty)
  `(save-excursion (goto-char (point-min) 
                              )(while (< (point) (point-max))
                                ,rest ,resty
                                )))

;; it must return
(defun praise-emacs (iters)
  "sings the praises of the sacred emacs"
  (interactive "p")
  (let* ((buffer-name "*Gloria Emacs*"))
    (with-current-buffer (get-buffer-create buffer-name)
      (dotimes (n iters )
        (insert "All praise to Emacs the eternal, the omnipotent, the sacred and the profane, the blessed and holy, the One True Editor\n"))
      (switch-to-buffer buffer-name)
      (make-buffer-read-only)
      )))

;; keep this around as example of generating text
;; (let* ((buffer-name (uuid-string)))
;;         (with-current-buffer (get-buffer-create buffer-name)
;;           (insert "the quick brown fox"))
;;         (switch-to-buffer buffer-name))
;; 
;; may be useful as My First Macro


(defun kill-readonly-buffers ()
  "Kill buffers that are read only"
  (interactive)
  (dolist (buffer (buffer-list))
    (with-current-buffer buffer
      (if buffer-read-only
          (kill-buffer)))))

;; useful in the minibuffer
(defun backwards-kill-line ()
  (interactive)
  (move-beginning-of-line nil)
  (kill-line))

(require 'uuid)
(defun new-unique-buffer ()
  "switches to a unique buffer with a name based on the date and a uuid"
  (interactive)
  (progn
    ;; (push-windows)
    ;; (delete-other-windows)
    (switch-to-buffer (concat (format-time-string "%b-%d-%H:%M:%S:%N")))))

;; (defun require (sexp)
;;   (interactive "MPackage to require:\n")
;;   (eval-expression sexp))
(defun comint-grab-current-input ()
  (interactive)
  (copy-region-as-kill (line-beginning-position) (line-end-position)))

;; use something like comint-proc-mark here

(defun convert-to-shellscript ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (insert "#!/bin/bash\n\n")
    ;; let the save hook take care of rest
    ))


(defun make-buffer-read-only()
  (interactive)
  (setq buffer-read-only t)
  (local-set-key (kbd "q") '(lambda () (interactive) (kill-buffer (current-buffer)))))


(defun eval-my-language ()
  "evaluates a string in my language"
  (interactive)
  (save-excursion
    (forward-line 0)
    (setq eml-beg (point))
    (end-of-line)
    (copy-region-as-kill eml-beg (point))
    (with-temp-buffer
      (yank)
      (goto-char (point-min))
      (if (looking-at "arse.*")
          (setq eml-ret "feck")
        (setq eml-ret "girls")))
    (insert "\n")
    (insert eml-ret)
    (insert "\n")))

;; from https://raw.github.com/gist/1440540/f29f488fbf845f8922257154ad41bb8996f562e7/interpolate.el

(defvar interpolate-capture "%{\\([^}]+\\)}")

(defun interpolate-wrap-key (str sym)
  (get sym (intern (concat ":" str))))

(defun interpolate- (str pl f)
  (if (string-match interpolate-capture str 0)
      (let* ((key (match-string 1 str))
             (new-str (replace-match "%" t nil str))
             (new-key (funcall f key)))
        (interpolate- new-str (cons new-key pl) f))
    (cons str (reverse pl))))

(defun interpolate (str)
  (let ((result (interpolate- str () (lambda (x) (eval (intern x))))))
    (apply 'format result)))

(defun interpolate-plist (str sym)
  (let* ((wrapper (lambda (str) (interpolate-wrap-key str sym)))
         (result (interpolate- str () wrapper)))
    (apply 'format result)))

;; (provide 'interpolate)


(eval-after-load 'text-mode
  '(define-key text-mode-map (kbd "\C-l") (lambda () (interactive) (fill-paragraph-or-region t))))

(defun unfill-paragraph ()
  "Replace newline chars in current paragraph by single spaces.
This command does the reverse of `fill-paragraph'."
  (interactive)
  (let ((fill-column 90002000))
    (fill-paragraph nil)))

(defun unfill-region (start end)
  "Replace newline chars in region by single spaces.
This command does the reverse of `fill-region'."
  (interactive "r")
  (let ((fill-column 90002000))
    (fill-region start end))) 

;; (defun grab-last-message-output ()
;;   (interactive)
;;   (save-excursion
;;     (with-current-buffer "*Messages*")
;;     (goto-char (point-max))
;;     (message (string (line-beginning-position)))
;;     (copy-region-as-kill (line-beginning-position) (point-max))))



(defun ipaddr-bounds-of-ipaddr-at-point ()
  "Return the start and end points of an ipv4 address
   The result is a paired list of character positions for an ipv4 address
   located at the current point in the current buffer.  for now we use
   (incorrect) definition that an IP is any string of digits and the dot
   (i.e. 10.0.3.244)"

  (save-excursion
    (skip-chars-backward ".0123456789")
    (if (looking-at "[0-9\.]+")
        (cons (point) (match-end 0)) ; bounds of integer
      nil))) ; no integer at point

(put 'ipaddr 'bounds-of-thing-at-point
     'ipaddr-bounds-of-ipaddr-at-point)

;;(beginning-of-thing 'integer)
;; (end-of-thing 'integer)

(defun forward-integer (&optional arg)
  "Move point forward ARG (backward if ARG is negative).
  Normally returns t if integer moved, else nil."
  (interactive "p")
  (let ((arg (or arg 1)))
    (while (< arg 0)
      (integer-beginning-of-integer)
      (setq arg (1+ arg)))
    (while (> arg 0)
      (integer-end-of-integer)
      (setq arg (1- arg)))))

(defun backward-integer (&optional arg)
  "Move backward until encountering the beginning of an integer.
  With argument, do this ARG many times."
  (interactive "p")
  (let ((arg (or arg 1)))
    (forward-integer (- 0 arg))))

(defun browse-next-url()
  (interactive)
  "finds the next url and grabs it"
  (save-excursion
    (re-search-forward "http://")
    (browse-url (thing-at-point 'url))))

(defun zap-upto-char (arg char)
  "Kill up to and including ARG'th occurrence of CHAR.
Goes backward if ARG is negative; error if CHAR not found."
  (interactive "*p\ncZap to char: ")
  (kill-rqegion (point) (progn
                          (search-forward (char-to-string char) nil nil arg)
                          (goto-char (if (> arg 0) (1- (point)) (1+ (point))))
                          (point))))

(defun send-to-shell ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (let ((beg (point))) (forward-line 1) (shell-command (buffer-substring-no-properties beg (point))))
    (switch-to-buffer "*Shell Command Output*") ;; may want to replace this with pop-buffer
    (make-buffer-read-only)
    ))

(defun jiggle-fullsize-window ()
  (interactive)
  (progn
    (set-frame-parameter nil 'fullscreen 'nil)
    (set-frame-parameter nil 'fullscreen 'fullboth)))

(defun use-theme (theme &optional no-confirm no-enable)
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
                             (mapcar 'symbol-name
                                     (custom-available-themes)))) nil nil))
  (progn
    (dolist (curtheme custom-enabled-themes)
      (disable-theme curtheme))
    (setq used-theme theme)
    ;; todo add to mode line
    (load-theme theme t)))  


(defun cycle-theme ()
  ;;; cycles through all the themes
  (interactive)
  (progn
    ;; hack: append car of list to list to allow it to cycle
    (let ((hacktheme (append (custom-available-themes) (list (car (custom-available-themes))))))
      (use-theme (following used-theme hacktheme)))
    ;; yuck! I'm still learning mode-line-format. important thing is appending (list (symbol-name used-theme)) to the end
    ))

(defun themes-with-face1 (theface)
  (let ((theme-file-list 
         (remove-if-not 
          (lambda (x) x) 
          (mapcar (lambda (x) 
                    (locate-file (concat (symbol-name x) "-theme.el") 
                                 custom-theme-load-path )) 
                  (custom-available-themes)))))
    (remove-if-not 
     (lambda (f) 
       (file-contains f (symbol-name theface))) theme-file-list)))

(defun themes-with-all-faces (facelist)
  (delete-dups
   (reduce (lambda (x y) (append x y))
           (mapcar (lambda (f) (themes-with-face1 f) )  facelist))))


(defun themes-with-face (theface) 
  (interactive (list (read-face-name "Face to search for" nil nil)))
  (message (format "%s" (themes-with-face1 theface))))

(defun collect-regexp-results (regex)
;;; collects all the matches of regex in a buffer called *collect-result*
;;; then switches to that buffer
;;; TODO refactor this to take the region as a parameter
  (interactive "Mregex to search for: ")
  (let ((curmin (region-or-buffer-beginning))
        (curmax (region-or-buffer-end)))
    (save-excursion
      (goto-char curmin)
      ;; (goto-char (region-or-buffer-beginning))
      (while (re-search-forward regex curmax t)
        (let ((retval (match-string-no-properties 0)))
          (with-current-buffer (get-buffer-create "*collect results*")
            (insert retval)
            (insert "\n"))))
      (switch-to-buffer "*collect results*"))))

(defun collect-ip-addresses ()
  (interactive)
  (collect-regexp-results "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+"))

;;; not sure how useful this is. I tried to use this to place a 
;;; variable value into minibuffer, did not seem to work
;;; at least for regexen
(defun eval-expression-with-replace (expr)
  (interactive (list (let ((minibuffer-completing-symbol t))
                       (read-from-minibuffer "Eval: "
                                             nil read-expression-map t
                                             'read-expression-history))))
  (eval-expression expr t))

(defun gmail-simple-reader ()
  (interactive)
  (let ( (thebuffer (get-buffer-create "*Simple Gmail Reader*")))
    (with-current-buffer thebuffer
      (delete-region (point-min) (point-max))
      (mapcar
       (lambda (entry)
         (insert-string
          (propertize 
           (format "%s    %-20s    %s    %s\n"
                   (cadr (assoc 'date entry))
                   (cadr (assoc 'author entry))
                   (cadr (assoc 'title entry))
                   (cadr (assoc 'summary entry)))
           'link (assoc 'link entry))))
       gmail-notifier-unread-entries)
      (local-set-key (kbd "<return>") (lambda () (interactive) (browse-url (cadr  (get-text-property (point) 'link))))))
    (switch-to-buffer thebuffer)))



(defun find-in-buffers (r)
  (interactive "Mregex to search for: ")
  (remove-if-not
   (lambda (x)
     (with-current-buffer x
       (save-excursion
         (goto-char (point-min))
         (search-forward r (point-max) t)
         )))
   (buffer-list)))

;; from http://stackoverflow.com/questions/2238418/emacs-lisp-how-to-get-buffer-major-mode
(defun buffer-mode (buffer-or-string)
  "Returns the major mode associated with a buffer."
  (with-current-buffer buffer-or-string
    major-mode))

(defun clean-up-buffers ()
  (interactive)
  (mapcar (lambda (y) (kill-buffer y)) 
          (remove-if-not (lambda (x) 
                           (or 
                            (s-starts-with? "*-jabber" (buffer-name x) )
                            (s-starts-with? "*curl*" (buffer-name x))
                            ;; (member x (tramp-list-remote-buffers))
                            )) 
                         (buffer-list))))

;; from http://whattheemacsd.com/project-defuns.el-01.html#disqus_thread
(defmacro project-specifics (name &rest body)
  (declare (indent 1))
  `(progn
     (add-hook 'find-file-hook
               (lambda ()
                 (when (string-match-p ,name (buffer-file-name))
                   ,@body)))
     (add-hook 'dired-after-readin-hook
               (lambda ()
                 (when (string-match-p ,name (dired-current-directory))
                   ,@body)))))

;; (project-specifics "projects/zombietdd"
;;   (set (make-local-variable 'slime-js-target-url) "http://localhost:3000/")
;;   (ffip-local-patterns "*.js" "*.jade" "*.css" "*.json" "*.md"))

(defun file-contains (f s)
  (with-temp-buffer
    (insert-file f)
    (goto-char (point-min))
    (search-forward s nil t)))

(defun zap-before-char (n char)
  (interactive (list (prefix-numeric-value current-prefix-arg)
                     (read-char "Zap up to char: " t)))
  (progn
    (zap-to-char n char)
    (insert char)))

(defun multiyank (times) (interactive "p") (loop for i from 1 to times do (yank)))

(defun org-demote-region () 
  (interactive) 
  (let ((rb (region-beginning))
        (re (region-end)))
    (save-excursion 
      (message (format "%d %d" rb re))
      (goto-char (region-beginning)) 
      (message (format "ddd %d" (point)))
      (beginning-of-line) 
      (message (format "aaa  %d" (point)))
      (while (< (point) re) 
        (progn 
          (org-demote-subtree) 
          (org-forward-heading-same-level))))))


(setq jabber-alert-message-hooks '(jabber-message-echo jabber-message-scroll))

(defun jabber-to-master-log (FROM BUFFER TEXT PROPOSED-ALERT)
  (progn (message TEXT)
         (with-current-buffer (get-buffer-create "*jabber-all-messages*")
           (progn 
             (goto-char (point-max))
             (insert 
              (propertize (format "%s %s \n" FROM TEXT ) 
                          'buffer
                          BUFFER))
             (local-set-key (kbd "RET") 
                            (lambda () (interactive)
                              (switch-to-buffer (get-text-property (point) 'buffer))))))))


(add-hook 'jabber-alert-message-hooks
          'jabber-to-master-log)

(defun shell-command-with-return (command) 
  (interactive ;; interactive form is cut and pasted from shell-command in simple.el
   (list
    (read-shell-command "Shell command: " nil nil
                        (let ((filename
                               (cond
                                (buffer-file-name)
                                ((eq major-mode 'dired-mode)
                                 (dired-get-filename nil t)))))
                          (and filename (file-relative-name filename))))
    current-prefix-arg
    shell-command-default-error-buffer))
  (with-temp-buffer
    (shell-command command 1) ;; in the temp buffer
    (buffer-substring (point-min) (point-max))
    ))


(defun close-sexp ()
  ;; closes the s-expression at point
  ;; by computing how many open parens and close parens
  ;; there are and inserting the appropriate number
  ;; bug: doesnt handle backquoted parens like \( \) properly
  (interactive)
  (let ((pt (point))
        (numopen 0)
        (numclose 0))
    (save-excursion
      (beginning-of-buffer)
      (while (< (point) pt)
        (if (eq (char-after) ?\()
            (setq numopen (+ 1 numopen)))
        (if (eq (char-after) ?\))
            (setq numclose (+ 1 numclose))) 
        (forward-char 1) )) 
    (dotimes (n (- numopen numclose))
      (insert-char ?\)))))

(defun comment-sexp () (interactive)
  (save-excursion
    (paredit-backward-up)
    (let ((cur (point)))
      (paredit-forward)
      (comment-region cur (point)))))

;; (defun try-expand-dabbrev-matching-buffers (old)
;;   (let ((matching-buffers (--filter
;;                            (eq major-mode (with-current-buffer it major-mode))
;;                            (buffer-list))))
;;     (cl-flet ((buffer-list () matching-buffers))
;;       (try-expand-dabbrev-all-buffers old))))

(defun collapse-buffer ()
	(interactive)
	(progn
		(end-of-buffer)
		(beginning-of-line)
		(while (> (point ) (point-min))
							;; (message "feckarse")
				(beginning-of-line)
				;; (message (format "%d "(point)) )
				(if (eq (preceding-char) ?\n)
						(progn (delete-region (point) (1- (point))))
					))))

(defun kill-isearch-match ()
    "Kill the current isearch match string and continue searching."
    (interactive)
    (kill-region isearch-other-end (point)))

(define-key isearch-mode-map [(control k)] 'kill-isearch-match)


;; takes everything in the buffer matching regexp and puts it in a buffer
(defun extract-regexp (regexp)
	(beginning-of-buffer)
	(if (buffer-live-p "*Extract output*")
			(kill-buffer "*Extract output*"))
	(while (re-search-forward regexp (point-max) "please return nil")
		(copy-region-as-kill (match-beginning 0) (match-end 0))
		 (with-current-buffer (get-buffer-create "*Extract Output*")
			 (yank)
			 (insert ?\n)
			 ))
	(switch-to-buffer "*Extract Output*")
	)

;; example use. 
(defun extr ()
	(interactive)
	(extract-regexp "foobar")
	)

(defun extract-ips ()
	(interactive)
	(extract-regexp "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*")
			 )
