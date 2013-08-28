(global-set-key (kbd "C-;") 'comment-or-uncomment-line-or-region)
(global-set-key (kbd "C-w") 'kill-line-or-region)
;; from http://stackoverflow.com/questions/916797/emacs-global-set-key-to-c-tab
(global-set-key (kbd "<C-tab>") 'indent-line-or-region)

;;;; key bindings moved here
;;;; explore using key chords for these
;;use clipboard to kill and save
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)
;;global-set-key [?\C-z] 'smart-iconify-or-deiconify-frame)
;; (global-set-key (kbd "A-g") (lambda () (interactive) (fill-paragraph 1))) 

(local-set-key (kbd "\C-l") (lambda () (interactive) (fill-paragraph-or-region t)))
(global-set-key (kbd "\C-ha") 'apropos)

;;; WINDOW SPLITING
;;; from http://xahlee.org/emacs/effective_emacs.html
(global-set-key (kbd "M-3") 'split-window-horizontally) ; was digit-argument
(global-set-key (kbd "M-4") 'split-window-vertically) ; was digit-argument
(global-set-key (kbd "M-1") 'delete-other-windows) ; was digit-argument
(global-set-key (kbd "M-k") 'other-window) ; was center-line

(global-set-key (kbd "C-'") 'er/expand-region)

;;bind C-shift-r to locate to mimic eclipse behavior
;;global-set-key (kbd "C-S-r") 'locate)
(global-set-key (kbd "C-S-r") 'locate-remember)
;;(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-z") 'smex)

(global-set-key "\C-c\C-k" 'compile)
;;its normally bound to execute-extended-command
;;use C-z for M-x

(global-set-key "\C-x\C-f" 'ido-find-file)

;;(define-key locate-mode-map "\M-g"    'diredp-do-grep) ; `M-g'

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-x\C-x" 'mark-page)
;;;;Change C-x C-b behavior so it uses bs; shows only interesting
;;;;buffers.
(global-set-key "\C-x\C-b" 'bs-show)
;;change C-x k to bury, not kill, the buffer
;;global-set-key "\C-xk" 'bury-buffer)
;;change C-x C-e to eval the sexp the point is currently in, not the preceding one
(global-set-key "\C-x\C-e" 'eval-defun)
(global-set-key (kbd "s-g") 'magit-status)
;; use isearch forward regexp
(global-set-key "\C-s" 'isearch-forward-regexp)
(global-set-key (kbd "C-S-t") 'shell)
(global-set-key (kbd "C-S-b") 'list-buffers)
;;C-o was "open line" which I've NEVER used in a decade
(global-set-key "\C-o" 'ido-find-file)
;;lets try these key bindings

;;I hate using C-x 1 to delete other window
(global-set-key (kbd "C-M-w") 'delete-other-windows)
(global-set-key (kbd "C-=") 'goto-line)

;;come up with an indent region or line
;;(global-set-key (kbd "C-") 'indent-region)

;; (key-chord-define-global "jk" 'smex)

;; os x cloverleaf-key bindings. another niceness of not using meta
(global-set-key (kbd "s-:") 'eval-expression)
(global-set-key (kbd "s-n") (lambda (&optional x) 
                              (interactive (list current-prefix-arg))
                              (if current-prefix-arg
                                 (let (default-major-mode emacs-lisp-mode)
                                   (new-unique-buffer))
                                (new-unique-buffer))))

(global-set-key (kbd "s-t") 'new-unique-buffer) ;; to match behavior with new-tab
(global-set-key (kbd "s-y") 'yank-pop) ;; to match behavior with new-tab
(global-set-key (kbd "s-/") (lambda (&optional x) 
                              (interactive (list current-prefix-arg))
                              (if current-prefix-arg
                                 (funcall (eval-defun nil ))
                                (eval-defun nil)))) ;; much nicer than C-x C-e...or is it?
(global-set-key (kbd "s-]") 'completion-at-point) ;; consider p-complete
(global-set-key (kbd "s-w") 'kill-buffer) ;; 
(global-set-key (kbd "s-!") 'shell-command) ;; was exchange point and mark
(global-set-key (kbd "C-<") 'beginning-of-buffer)
(global-set-key (kbd "C->") 'end-of-buffer) 
;; (global-set-key (kbd "s-<") 'beginning-of-buffer) 
;; (global-set-key (kbd "s->") 'end-of-buffer) 
;; lets try vim style bindings again!
(global-set-key (kbd "s-h") 'backward-char) ;; 
(global-set-key (kbd "s-j") 'previous-line) ;; was exchange point and mark
(global-set-key (kbd "s-k") 'next-line) ;; was exchange point and mark
(global-set-key (kbd "s-l") 'forward-char) ;; was exchange point and mark
(global-set-key (kbd "C-!") 'shell-command) ;; was exchange point and mark
(global-set-key (kbd "C-|") 'shell-command-on-region) ;; was exchange point and mark
(global-set-key (kbd "C-:") 'eval-expression) ;; was exchange point and mark

;; (define-key 'comint-mode-map (kbd "s-p") 'comint-prev-prompt)
;; (define-key 'comint-mode-map (kbd "s-n") 'comint-next-prompt)

;; (global-set-key (kbd "C-x C-u") 'backwards-kill-line)
(define-key minibuffer-local-map (kbd "C-u") 'backwards-kill-line)
(define-key minibuffer-local-map (kbd "C-w") 'universal-argument)
(define-key minibuffer-local-map (kbd "C-p") 'previous-history-element)
(define-key minibuffer-local-map (kbd "C-n") 'next-history-element)
(define-key minibuffer-local-map (kbd "C-:") 'eval-expression-with-replace)

(global-set-key (kbd "C-.") 'flyspell-correct-word)
;; lets try this, using os x to page up and down
(define-key global-map (kbd "<s-up>") 'scroll-down-command)
(define-key global-map (kbd "<s-down>") 'scroll-up-command)

;; better copy region as kill
(define-key global-map (kbd "C-S-w") 'copy-region-as-kill)

(define-key global-map 
  (kbd "C-|")
  (lambda (start end command) (interactive "r\nMcommand: ") (shell-command-on-region start end command t)))

(defmacro make-key (keyseq map command)
  ;; binds keyseq to command in map
  ;; keyseq should look like what you feed to 'kbd', i.e. C-f or s-n
  ;; map should be a keymap, i.e. global-map
  ;; command should be a single command. if more than 1 command progn might work
  `(define-key ,map (kbd ,keyseq) (lambda () (interactive) ,command)))

(setq benhsu-word-boundary "[ ]+")  
(make-key "s-f" global-map (re-search-forward benhsu-word-boundary))

;; s-d (d for delimiter) marks from the next instance of comma
;; todo make it interactive
(make-key "s-d" global-map (progn
                             (re-search-forward ",")
                             (let ((pt (point)))
                               (re-search-forward ",")
                               (kill-region pt (point)))))

(make-key "<s-S-left>" global-map (windmove-left))
(make-key "<s-S-right>" global-map (windmove-right))
(make-key "<s-S-up>" global-map (windmove-up))
(make-key "<s-S-down>" global-map (windmove-down))
(make-key "s-)" global-map (close-sexp))

(make-key "C-a" global-map 
          (let ((beginning-no-tab (save-excursion (back-to-indentation) (point))))
            ;;; goes to the first line that is not whitespace
            ;;; if already there go to beginning of line
             (cond ((equal (point) beginning-no-tab)
                    (move-beginning-of-line nil))
                   (t (back-to-indentation)))))
(make-key "C-c C-j" global-map (send-to-shell))

(global-set-key (kbd  "<s-backspace>") 'winner-undo)
(global-set-key (kbd  "<S-s-backspace>") 'winner-redo)

(global-set-key (kbd  "C-h l") 'find-library)
(global-set-key (kbd  "C-h ;") 'find-function)
;; (global-set-key (kbd "C-h s") '(lambda () (interactive) (find-function (function-called-at-point))))
(global-set-key (kbd "C-h F") 'find-function)

(global-set-key (kbd "s--") 'split-window-below)
(global-set-key (kbd "s-=") 'split-window-right)

(make-key "s-f" dired-mode-map (find-dired "." find-args))

;; improvements to isearch
(make-key "C-k" isearch-mode-map (progn
                                   (backward-sexp)
                                   (kill-sexp)
                                   ))

(global-set-key (kbd  "C-s-n") 'scroll-other-window)
(global-set-key (kbd  "C-S-s-v") 'scroll-other-window-down)

(global-set-key (kbd "M-z") 'zap-before-char)
(global-set-key (kbd "C-y") 'multiyank)

;; I hate M-% 
(define-key isearch-mode-map (kbd "s-5") 'isearch-query-replace-regexp)
;; and typing out \(
(define-key isearch-mode-map (kbd "C-9") 
  (lambda () (interactive) (progn 
                             (let ((last-command-event )))
                             (isearch-process-search-char ?\\) 
                             (isearch-process-search-char ?\())))

(define-key isearch-mode-map (kbd "C-0") 
  (lambda () (interactive) (progn 
                             (let ((last-command-event )))
                             (isearch-process-search-char ?\\) 
                             (isearch-process-search-char ?\)))))


;; do something about tab complete in it!


