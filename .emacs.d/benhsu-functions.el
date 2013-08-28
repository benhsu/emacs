;; incomplete
(defun grep-buffers ()
  ;; (interactive "Mstring to grep for: ")
  (interactive)
  (dolist (b (buffer-list))             ;fwaf
    (with-current-buffer b
      (let (name (buffer-name))
        (if (search-forward "grep" nil t 1)
            (with-current-buffer (get-buffer-create "*Grep Bait*")
              (insert name)))))))


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

(defun backwards-kill-line ()
  (interactive)
  (move-beginning-of-line nil)
  (kill-line))

;; (defun dired-expand-all-dirs()
;;   (interactive)
;;   (save-excursion
;;     (
     
;;     )))

;; 

(require 'uuid)
(defun new-unique-buffer ()
  "switches to a unique buffer with a name based on the date and a uuid"
  (interactive)
  (progn
    ;; (push-windows)
    ;; (delete-other-windows)
    (switch-to-buffer (concat (format-time-string "%b-%d-%H:%M:%S:%N")))
)
  )

(defun clear-windows ()
    (push-windows)
    (delete-other-windows)
)

(global-set-key (kbd "\C-o") (lambda () (interactive) 
                              (progn
                                (undo)
                                 (exchange-point-and-mark))))

(defun camelCase (p1 p2)
  (interactive "r")
  (save-excursion
    (goto-char p1)
    (while (not (eq (point) p2))
      (progn
        (if (looking-at "_")
            (progn (delete-char 1)
                   (set-mark)
                   (forward-char)
                   (upcase-region)))

        (forward-char)))))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))
    
;; (defun require (sexp)
;;   (interactive "MPackage to require:\n")
;;   (eval-expression sexp))
(defun comint-grab-current-input ()
  (interactive)
  (copy-region-as-kill (line-beginning-position) (line-end-position)))

;; use something like comint-proc-mark here

;; my first elisp, it was so long ago
(defun cj-helper ()
  "shows what field our expression corresponds to"
  (interactive)
  (save-excursion
    (setq current-position (point))
    (beginning-of-line)
    ; count how many "${tab}"'s there are
    (let ((tab-count -1))  ; count
      (while (and (<= (point) current-position) (search-forward "${tab}" nil t))
        (incf tab-count)
      )
      ; now that we have the number of tabs, count number of |s
      (beginning-of-buffer)
      (search-forward "&PARAMETERS=")
      (message "after %d" (point))
      (let ((pipe-count 0))
        (while (< pipe-count tab-count)
          (search-forward "|")
          (message "at is %d" (point))
          (incf pipe-count)
          )
        (message "result %d %d %d" tab-count pipe-count (point))
        (let ((pipe-start (point)))
          (search-forward "|")
          (let ((pipe-end (point)))
          (message (concat "at " (buffer-substring pipe-start (- pipe-end 1))))
          )))
      )))

;; from Chris Hungry Man Yacco
(defun sew (victim victims)
  (append victim victims))

;; 
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
    (insert "\n")
           
  ))

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

(defun indent-line-or-region ()
  (interactive)
  (if (region-active-p)
      (indent-region (region-beginning) (region-end))
    (indent-region (line-beginning-position) (line-end-position))))

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



(defun use-this-buffer ()
  (interactive)
  (setq my-buffer (current-buffer)))

;; now put it in a macro!!!

(defmacro with-this-buffer (body) (list 'with-current-buffer my-buffer body))

(require 'thingatpt)
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

;; (with-my-buffer 
;; (progn 
;;   (setq ip-list ())
;;   (setq x (re-search-forward "[0-9\.]+" (point-max) t))
;;   (while x
;;     (backward-char)
;;     (message (car ip-list))
;;     (setq ip-list (cons (thing-at-point 'ipaddr) ip-list))
;;     (forward-char)
;;     (setq x (re-search-forward "[0-9\.]+" (point-max) t)))
;;   ip-list
;;   ))

(defun join-all-lines () 
  (interactive)
 (progn 
   (goto-char (point-max)) 
   (beginning-of-line)
   (while (not (equal (point) (point-min)))
     (delete-indentation)
     (beginning-of-line))))

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
    (switch-to-buffer "*Shell Command Output*")
    (make-buffer-read-only)
    ))
    


(defun jiggle-fullsize-window ()
       (interactive)
       (progn
       (set-frame-parameter nil 'fullscreen 'nil)
       (set-frame-parameter nil 'fullscreen 'fullboth)))

(defun stop-using-minibuffer ()
  "kill the minibuffer"
  (when (and (>= (recursion-depth) 1) (active-minibuffer-window))
    (abort-recursive-edit)))

(add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)

(defun use-theme (theme &optional no-confirm no-enable)
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
			     (mapcar 'symbol-name
				     (custom-available-themes))))
    nil nil))
  (progn
    (dolist (curtheme custom-enabled-themes)
      (disable-theme curtheme))
    (setq used-theme theme)
    ;; todo add to mode line
    (load-theme theme t)))  


(defun following(n l)
  (if (eq n (car l)) (car (cdr l)) (following n (cdr l))))
  

(defun cycle-theme ()
  ;;; cycles through all the themes
  (interactive)
  (progn
    ;; hack: append car of list to list to allow it to cycle
    (let ((hacktheme (append (custom-available-themes) (list (car (custom-available-themes))))))
      (use-theme (following used-theme hacktheme)))
    ;; yuck! I'm still learning mode-line-format. important thing is appending (list (symbol-name used-theme)) to the end
    ))

(defmacro with-this-buffer (body) (list 'with-current-buffer my-buffer body))

(defun region-or-buffer-beginning ()
  ;;; returns region-beginning if region set, otherwise point-min
  (if (region-active-p) (region-beginning) (point-min)))

(defun region-or-buffer-end ()
  ;;; returns region-end if region set, otherwise point-max
  (if (region-active-p) (region-end) (point-max)))


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
;; stab at generalizing this

(defun line-or-region-wrapper (func)
  (interactive)
  (if (region-active-p)
      (funcall func (region-beginning) (region-end))
    (funcall func (line-beginning-position) (line-end-position))))

(defun comment-or-uncomment-line-or-region ()
  (interactive)
  (line-or-region-wrapper 'comment-or-uncomment-region))

(defun indent-line-or-region ()
  (interactive)
  (line-or-region-wrapper 'indent-region))

(defun kill-line-or-region ()
  (interactive)
  (if (region-active-p)
      (kill-region (point) (mark) )
    (kill-line )))


(defun region-explore (x y)
  (interactive "r")
  (message (format "%d %d" x y)))

;; use this to kill curl-processes in gmail
;; (mapcar 'kill-buffer (remove-if-not (lambda (x) (s-starts-with-p "*curl" (buffer-name x))) (buffer-list)))

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

(defun compose-help (fs x) (cond ((equal fs '()) x) ((equal (cdr fs) '() ) (list (car fs) x)) (t (list (car fs) (compose-help (cdr fs) x)))))

(defmacro compose (fs x) (compose-help fs x))

(defmacro diff (l fx) `(cond ((< (length ,l) 2) (error "fsck"))
                               ((= (length ,l) 2) (,fx (car ,l) (car (cdr ,l))))
                               (t (cons (,fx (car ,l) (car (cdr ,l))) (diff (cdr ,l) ,fx)))))

(cadr (assoc 'author (car gmail-notifier-unread-entries)))


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
           (cadr (assoc 'summary entry))
           )
          'link (assoc 'link entry)
          ))
         )
       gmail-notifier-unread-entries
              )
      (local-set-key (kbd "<return>") (lambda () (interactive) (browse-url (cadr  (get-text-property (point) 'link)))))
      )
    (switch-to-buffer thebuffer)
    )
  )



;; failed experiment. web service is not sufficiently available
;; (defun hn-reader ()
;; (interactive)
;; (let ( (thebuffer (get-buffer-create "*Hacker News*"))
;;        (url-retrieve "http://api.ihackernews.com/page"
;;     (with-current-buffer thebuffer
;;       (delete-region (point-min) (point-max))
;;       (mapcar
;;        (lambda (entry)
;;          (insert-string
;;          (propertize 
;;           (format "%s    %-20s    %s    %s\n"
;;            (cadr (assoc 'date entry))
;;            (cadr (assoc 'author entry))
;;            (cadr (assoc 'title entry))
;;            (cadr (assoc 'summary entry))
;;            )
;;           'link (assoc 'link entry)
;;           ))
;;          )
;;        gmail-notifier-unread-entries
;;               )
;;       (local-set-key (kbd "<return>") (lambda () (interactive) (browse-url (cadr  (get-text-property (point) 'link)))))
;;       )
;;                      ))

;;     (switch-to-buffer thebuffer)
;;     )
;; )


;; from http://nullprogram.com/blog/2010/11/15/
(defun compose (&rest funs)
  "Return function composed of FUNS."
  (lexical-let ((lex-funs funs))
    (lambda (&rest args)
      (reduce 'funcall (butlast lex-funs)
              :from-end t
              :initial-value (apply (car (last lex-funs)) args)))))


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

;; (defun hn-reader ()
;; (interactive)
;; (let ( (thebuffer (get-buffer-create "*Hacker News*"))
;;        (url-retrieve "http://api.ihackernews.com/page"
;;     (with-current-buffer thebuffer
;;       (delete-region (point-min) (point-max))
;;       (mapcar
;;        (lambda (entry)
;;          (insert-string
;;          (propertize 
;;           (format "%s    %-20s    %s    %s\n"
;;            (cadr (assoc 'date entry))
;;            (cadr (assoc 'author entry))
;;            (cadr (assoc 'title entry))
;;            (cadr (assoc 'summary entry))
;;            )
;;           'link (assoc 'link entry)
;;           ))
;;          )
;;        gmail-notifier-unread-entries
;;               )
;;       (local-set-key (kbd "<return>") (lambda () (interactive) (browse-url (cadr  (get-text-property (point) 'link)))))
;;       )
;;                      ))

;;     (switch-to-buffer thebuffer)
;;     )
;; )

(defun collapse-lines ()
     (interactive)
     ;; TODO make it mark buffer or region
     (save-excursion
       (end-of-buffer)
       (while t
         (delete-indentation))))

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

(defvar window-configurations '())
(defun push-windows ()
  (interactive)
  (setq window-configurations (cons (current-window-configuration) window-configurations))
  )

(defun pop-windows ()
  (interactive)
  (set-window-configuration (pop window-configurations))
  )

(defun file-contains (f s)
  (with-temp-buffer
    (insert-file f)
    (goto-char (point-min))
    (search-forward s nil t)))

(defun themes-with-face1 (theface)
  (let ((theme-file-list 
         (remove-if-not 
          (lambda (x) x) 
          (mapcar (lambda (x) 
                    (locate-file (concat (symbol-name x) "-theme.el") 
                                 custom-theme-load-path )) 
                  (custom-available-themes))) 
                       ))
    (remove-if-not 
     (lambda (f) 
       (file-contains f (symbol-name theface))) theme-file-list)))

(defun themes-with-all-faces (facelist)
  (delete-dups
   (reduce (lambda (x y) (append x y))
             (mapcar (lambda (f) (themes-with-face1 f) )  facelist))) 
)


(defun themes-with-face (theface) 
     (interactive (list (read-face-name "Face to search for" nil nil)))
     (message (format "%s" (themes-with-face1 theface))))

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

