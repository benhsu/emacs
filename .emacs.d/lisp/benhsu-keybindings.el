
;; https://github.com/rolandwalker/simpleclip/issues/1
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)

;; https://gist.github.com/railwaycat/3498096
(global-set-key [(super a)] 'mark-whole-buffer)
(global-set-key [(super v)] 'yank)
(global-set-key [(super c)] 'kill-ring-save)
(global-set-key [(super s)] 'save-buffer)
(global-set-key [(super l)] 'goto-line)
(global-set-key [(super w)]
                (lambda () (interactive) (delete-window)))
(global-set-key [(super z)] 'undo)


(global-set-key (kbd "C-z") 'smex)
(global-set-key (kbd "C-S-r") 'locate-remember)

;;;; key bindings moved here
;;;; explore using key chords for these
;;use clipboard to kill and save
(global-set-key "\C-w" 'clipboard-kill-region)
(global-set-key (kbd "C-S-w")	 'clipboard-kill-ring-save)
(global-set-key "\M-w" 'clipboard-kill-ring-save)
(global-set-key "\C-y" 'clipboard-yank)

;; for help
(global-set-key (kbd	"C-h l") 'find-library)
;; (global-set-key (kbd "C-h s") '(lambda () (interactive) (find-function (function-called-at-point))))
(global-set-key (kbd "C-h F") 'find-function)

;; (global-set-key (kbd "C-x C-u") 'backwards-kill-line)
(define-key minibuffer-local-map (kbd "C-u") 'backwards-kill-line)
(define-key minibuffer-local-map (kbd "C-w") 'universal-argument)
(define-key minibuffer-local-map (kbd "C-p") 'previous-history-element)
(define-key minibuffer-local-map (kbd "C-n") 'next-history-element)
(define-key minibuffer-local-map (kbd "C-:") 'eval-expression-with-replace)

;; use isearch forward regexp
(global-set-key "\C-s" 'isearch-forward-regexp)

;; improvements to isearch
(make-key "C-k" isearch-mode-map (progn (backward-sexp) (kill-sexp)))

;; I hate M-%
;; maybe ctrl-j?
(global-set-key (kbd "s-r") 'query-replace-regexp)
(define-key isearch-mode-map (kbd "s-5") 'isearch-query-replace-regexp)
(define-key isearch-mode-map (kbd "C-x s") 'isearch-query-replace-regexp)
(define-key isearch-mode-map (kbd "C-x C-s") 'isearch-query-replace-regexp)
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


;; use s-n as "make a new file"
(global-set-key (kbd "s-n") (lambda (&optional x)
															(interactive (list current-prefix-arg))
															(if current-prefix-arg
																 (let (default-major-mode emacs-lisp-mode)
																	 (new-unique-buffer))
																(new-unique-buffer)
																(setq default-directory "~")
																)))

;; do something about tab complete in it!
(global-set-key (kbd "C-=") 'goto-line)
(global-set-key (kbd "C-:") 'eval-expression)
(global-set-key (kbd "s-g") 'magit-status)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-;") 'comment-or-uncomment-line-or-region)
(global-set-key (kbd "C-'") 'er/expand-region)

;; moving the point around
;; lets try this, using os x to page up and down
(global-set-key (kbd "C-<") 'beginning-of-buffer)
(global-set-key (kbd "C->") 'end-of-buffer)
(define-key global-map (kbd "<s-up>") 'scroll-down-command)
(define-key global-map (kbd "<s-down>") 'scroll-up-command)

;; cua like shit
(global-set-key (kbd "s-y") 'yank-pop)
(global-set-key (kbd "C-y") 'multiyank)
(global-set-key (kbd "M-z") 'zap-before-char)
(make-key "s-f" dired-mode-map (find-dired "." find-args))
(make-key "C-a" global-map
					(let ((beginning-no-tab (save-excursion (back-to-indentation) (point))))
						;;; goes to the first line that is not whitespace
						;;; if already there go to beginning of line
						 (cond ((equal (point) beginning-no-tab)
										(move-beginning-of-line nil))
									 (t (back-to-indentation)))))

;;C-o was "open line" which I've NEVER used in a decade
(global-set-key "\C-o" 'ido-find-file)
(global-set-key "\C-x\C-f" 'ido-find-file)

;;(define-key locate-mode-map "\M-g"		'diredp-do-grep) ; `M-g'

(global-set-key "\C-x\C-x" 'mark-page)
;;;;Change C-x C-b behavior so it uses bs; shows only interesting
;;;;buffers.
(global-set-key "\C-x\C-b" 'bs-show)
(global-set-key (kbd "C-S-b") 'list-buffers)
(global-set-key (kbd "s-w") 'kill-buffer) ;;
;;lets try these key bindings

(global-set-key (kbd "s-t") 'new-unique-buffer) ;; to match behavior with new-tab
(global-set-key (kbd "C-.") 'flyspell-correct-word)

;; put this in lexical binding!
(setq benhsu-word-boundary "[ ]+")
(make-key "s-f" global-map (re-search-forward benhsu-word-boundary))
;; s-d (d for delimiter) marks from the next instance of comma
;; todo make it interactive and not specific to (I venture) python
(make-key "s-d" global-map (progn
														 (re-search-forward ",")
														 (let ((pt (point)))
															 (re-search-forward ",")
															 (kill-region pt (point)))))

;; not sure how usefl this is
(global-set-key (kbd "\C-o")
								(lambda () (interactive)
									(progn (undo) (exchange-point-and-mark))))

(global-set-key (kbd "<s-left>") 'previous-buffer)
(global-set-key (kbd "<s-right>") 'next-buffer)

(global-set-key (kbd "s-\\") 'neotree-toggle)
