
;; why the fuck does haskell mode not ship with a sane default?
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(setq auto-mode-alist (cons '("\\.xml$" . nxml-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.txt$" . fundamental-mode))
(add-to-list 'auto-mode-alist '("\\.el.gz$" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("\\.pp$" . puppet-mode))
(add-to-list 'auto-mode-alist '("\\.erl$" . erlang-mode))


;;;;Use ANSI colors within shell-mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;;interpret and use ansi color codes in shell output windows
(ansi-color-for-comint-mode-on)

;; should be in lisp mode and control-0

;; wtf are these?
(global-set-key (kbd "C-!") 'shell-command)
(define-key global-map
	(kbd "C-|")
	(lambda (start end command) (interactive "r\nMcommand: ") (shell-command-on-region start end command t)))

;; git config modes
;; (require 'gitattributes-mode)
;;(require 'gitconfig-mode)
;;(require 'gitignore-mode)
(add-to-list 'auto-mode-alist '("^\.gitattributes$" . gitattributes-mode))
(add-to-list 'auto-mode-alist '("^\.gitconfig$" . gitconfig-mode))
(add-to-list 'auto-mode-alist '("^\.gitignore$" . gitignore-mode))
(add-to-list 'auto-mode-alist '("\.git/info/attributes$" . gitignore-mode))
(add-to-list 'auto-mode-alist '("\.git/config$" . gitignore-mode))
(add-to-list 'auto-mode-alist '("\.git/info/exclude$" . gitignore-mode))

;; markdown
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\.mdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\.md$" . markdown-mode))

;; go
(require 'go-mode-autoloads)
