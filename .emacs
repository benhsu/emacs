;; with apologies to the USMC:
;; this is my .emacs, there are many like it but this one is mine.
;; My emacs is my best friend. It is my life. I must master it as I must master my life.
;; My emacs, without me, is useless. Without my emacs, I am useless.

;;	Emacs is to Eclipse as a light saber is to a blaster — but a blaster is a lot easier for anyone to pick up and use -- yegge
;;		 "your fathers .emacs, an elegant weapon, for a more civilised age" ;; i am reminded of the story of the third-generation emacs user
;; ;;	 actually I think vim is the lightsaber (the more elegant weapon), emacs is more like the cosmic cube or green lantern ring

;; from http://stackoverflow.com/questions/658095/what-is-the-best-emacs-book-out-there
;; "You will never find a definitive Emacs book. Emacs arcana are passed on from druid to druid in the dead of night,
;; using much ritual and gnashing of teeth."


;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; set the load path

(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))
(let ((default-directory	"~/.emacs.d/elpa/"))
	(normal-top-level-add-subdirs-to-load-path))
(let ((default-directory	"~/.emacs.d/lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "~/.emacs.site.d/")

;; path for unix utils
(setq exec-path '("/Users/benhsu/bin" "/opt/local/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/usr/local/bin" "/opt/X11/bin" "/Users/benhsu/grails-1.2.1/bin") )

;; above seems to not work for gimme-cat
(setenv "PATH" (concat "/Users/benhsu/bin:" "/opt/local/bin:/opt/local/sbin:/usr/local/bin:" (getenv "PATH")))

;; from http://technical-dresese.blogspot.com/2012/12/encrypted-emacs-customizations.html
(add-to-list 'load-suffixes ".el.gpg")
;; (load "secrets.el.gpg" )

;; where we keep mysql passwords, separate file not in github
;; the "1" means dont throw an error if its not found
(load "passwords.el" 1)

;; put all my 'require's here
(load "benhsu-required.el")
(load "benhsu-functions.el")
(load "benhsu-windows.el")
(load "benhsu-region.el")

;; start emacs server
(server-start)
(display-time)

;; load part of file

(defun list-buffers-hotkey ()
	(interactive)
	(progn (list-buffers)
				 (switch-to-buffer "*Buffer List*")))

(set-variable 'cursor-type 'box)

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
	(global-font-lock-mode t))

;;;;While we are at it, always flash for parens.
(show-paren-mode 1)

;; enable visual feedback on selections
;;setq transient-mark-mode t)
;;(setq line-move-visual nil)
(visual-line-mode 1)

;; default to better frame titles
(setq frame-title-format
			(concat	 "%b - emacs@" system-name))
(setq inhibit-startup-message t)

(setq column-number-mode t) ;; turn on column number mode


;;;;What it says. Keeps the cursor in the same relative row during
;;;;pgups and dwns.
(setq scroll-preserve-screen-position t)
;;;;Start scrolling when 2 lines from top/bottom

;;; setting this to two broke comint modes like nrepls
(setq scroll-margin 0)


;;;;The autosave is typically done by keystrokes, but I'd like to save
;;;;after a certain amount of time as well.
(setq auto-save-timeout 1800)

;; Automatic reverting of buffers
(autoload 'auto-revert-mode "autorevert" nil t)
(autoload 'turn-on-auto-revert-mode "autorevert" nil nil)
(autoload 'global-auto-revert-mode "autorevert" nil t)
(global-auto-revert-mode 1)
;;auto-revert-interval 1)

;;;;;Accelerate the cursor when scrolling.
(load "accel" t t)
;;;;This apparently allows seamless editting of files in a tar/jar/zip
;;;;file.
(auto-compression-mode 1)



(if (fboundp 'scroll-bar-mode) (scroll-bar-mode 1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode 1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode 1))
(defalias 'yes-or-no-p 'y-or-n-p)

;;;;Change backup behavior to save in a directory, not in a miscellany
;;;;of files all over the place.
(setq
 backup-by-copying t			; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves"))		; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)				; use versioned backups

;; change location of the "#" files
(setq backup-directory-alist
					`((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
					`((".*" ,temporary-file-directory t)))

;; do I want this or org mode or lisp mode

(setq default-major-mode 'text-mode)

(add-hook 'markdown-mode-hook (lambdaste (flyspell-mode 1)))


(add-hook 'text-mode-hook (lambdaste (flyspell-mode 1)))
(add-hook 'text-mode-hook (lambdaste (visual-line-mode 1)))
(add-hook 'text-mode-hook (lambdaste (rainbow-delimiters-mode 1)))

(add-hook 'org-mode-hook (lambdaste (flyspell-mode 1)))
(add-hook 'org-mode-hook (lambdaste (visual-line-mode 1)))
(add-hook 'org-mode-hook (lambdaste (rainbow-delimiters-mode 1)))


;;;;This sets garbage collection to hundred times of the default.
;;;;Supposedly significantly speeds up startup time. (Seems to work
;;;;for me,	 but my computer is pretty modern. Disable if you are on
;;;;anything less than 1 ghz).
(setq gc-cons-threshold 50000000)

;; for compiling!

;; byte compile the buffer
(add-hook 'after-save-hook 'emacs-lisp-byte-compile t t)

(setq byte-compile-warnings '(not nresolved
																	free-vars
																	callargs
																	redefine
																	obsolete
																	noruntime
																	cl-functions
																	interactive-only
																	))

;; make whitespace-mode use “¶” for newline and “▷” for tab.
;; together with the rest of its defaults

(setq whitespace-style '(face empty tabs lines-tail trailing))
(setq whitespace-line-column 120)

(setq whitespace-display-mappings
			'(
			(space-mark 32 [183] [46])					; normal space, ·
		(space-mark 160 [164] [95])
		(space-mark 2208 [2212] [95])
		(space-mark 2336 [2340] [95])
		(space-mark 3616 [3620] [95])
		(space-mark 3872 [3876] [95])
		(newline-mark 10 [182 10])					; newlne, ¶
		(tab-mark 9 [187 9] [92 9])))

;; hack around deprecated function in emacs 24.4
(defun package-desc-vers (foo)
  (package--ac-desc-version foo))

;;from sacha chua, add package manager if version si 24
(progn
  (package-initialize)
  ;; Add the original Emacs Lisp Package Archive
  (add-to-list 'package-archives
	       '("gnu" . "http://elpa.gnu.org/packages/"))
  (add-to-list 'package-archives
	       '("melpa-stable" . "http://stable.melpa.org/packages/") t)
  ;; (add-to-list 'package-archives
  ;;							'("elpa" . "http://tromey.com/elpa/"))
  ;; ;; Add the user-contributed repository
  ;; (add-to-list 'package-archives
  ;;							'("marmalade" . "http://marmalade-repo.org/packages/"))
)

;;; these are some packages

;;set up locate to use new thingie
(defun my-locate-make-command-line (arg)
	(interactive)
	(list "mdfind" arg))

;;set the 'locate' command to use emacs
;; (setq locate-command "locate")
;; (defun locate-make-command-line (search-string)
;;	 (list "/opt/local/libexec/gnubin/locate" "--regex" search-string))

(setq locate-make-command-line 'my-locate-make-command-line)
(defvar locate-history nil "History for locate")

(defun locate-remember (search-string)
	"calls locate, but remembers the last thing searched for"
	(interactive (list (read-from-minibuffer "Locate: " (car locate-history) nil nil 'locate-history)))
	(locate search-string))


(tramp-set-completion-function "ssh"
					 '((tramp-parse-hosts "/etc/hosts")
						 (tramp-parse-sconfig "/etc/ssh_config")
						 (tramp-parse-sconfig "~/.ssh/config")))

(defun dired-open-mac ()
	(interactive)
	(let ((file-name (dired-get-file-for-visit)))
		(if (file-exists-p file-name)
				(call-process "/usr/bin/open" nil 0 nil file-name))))


(define-key dired-mode-map "o" 'dired-open-mac)

;; from http://xahlee.org/emacs/elisp_idioms_batch.html
;; inserts marked files into *dired* buffer
;; TODO make it a separate buffer


(defun dired-cat ()

	(interactive)
	(defun my-process-file (fPath)
		"Process the file at path FPATH …"
		;; create temp buffer, process, when done, then write to fPath
		(get-buffer-create bName)
		(set-buffer bName)
		(insert-file-contents fPath)
		;; process it …
		)
	"apply myProcessFile function to marked files in dired."
	(let ((bName "smashed-cats"))
		(save-excursion
			(mapc 'my-process-file (dired-get-marked-files)))
		(switch-to-buffer bName)
		)
	)

(put 'dired-find-alternate-file 'disabled nil)

(eval-after-load 'dired
	'(define-key dired-mode-map "c" 'dired-view-file))
(eval-after-load 'dired
	'(define-key dired-mode-map (kbd "RET") 'dired-find-file))

;; I think custom set variables needs to be down here, after the custom packages (nyan mode)
;; are loaded
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Linum-format "%7i ")
 '(ansi-color-faces-vector
	 [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
	 ["#eee8d5" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#839496"])
 '(auth-source-save-behavior nil)
 '(column-number-mode t)
 '(comint-buffer-maximum-size 100000000)
 '(comint-completion-addsuffix t)
 '(comint-completion-autolist t)
 '(comint-input-ignoredups t)
 '(comint-move-point-for-output t)
 '(comint-scroll-show-maximum-output t)
 '(comint-scroll-to-bottom-on-input nil)
 '(compilation-message-face (quote default))
 '(compilation-scroll-output t)
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#657b83")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(debug-on-error t)
 '(fci-rule-character-color "#452E2E")
 '(fci-rule-color "#202020")
 '(foreground-color "#708183")
 '(frame-brackground-mode (quote dark))
 '(fringe-mode 4 nil (fringe))
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
	 (--map
		(solarized-color-blend it "#fdf6e3" 0.25)
		(quote
		 ("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2"))))
 '(highlight-symbol-foreground-color "#586e75")
 '(highlight-tail-colors
	 (quote
		(("#eee8d5" . 0)
		 ("#B4C342" . 20)
		 ("#69CABF" . 30)
		 ("#69B7F0" . 50)
		 ("#DEB542" . 60)
		 ("#F2804F" . 70)
		 ("#F771AC" . 85)
		 ("#eee8d5" . 100))))
 '(ido-ignore-directories (quote ("\\`CVS/" "\\`\\.\\./" "\\`\\./" "\\`\\.svn/")))
 '(ido-mode (quote both) nil (ido))
 '(ido-show-dot-for-dired t)
 '(indent-tabs-mode t)
 '(large-file-warning-threshold 50000000)
 '(line-number-mode t)
 '(linum-format " %6d ")
 '(magit-diff-use-overlays nil)
 '(magit-use-overlays nil)
 '(markdown-command "/opt/local/bin/multimarkdown")
 '(max-specpdl-size 50000)
 '(menu-bar-mode nil)
 '(nyan-animate-nyancat t)
 '(nyan-bar-length 32)
 '(nyan-wavy-trail t)
 '(org-refile-targets
	 (quote
		((org-agenda-files :tag . "(quote ((org-agenda-files :maxlevel . 3)
			(sr-org-refile-targets :maxlevel . 2)))")
		 (org-agenda-files :tag . ""))))
 '(org-special-ctrl-a/e t)
 '(org-startup-folded (quote showeverything))
 '(package-selected-packages
	 (quote
		(cider zlc zenburn-theme yas-jit yari yaml-mode workgroups with-editor wide-column websocket uuid unicode-fonts uni-confusables underwater-theme twilight-anti-bright-theme tuareg tree-mode top-mode theme-changer tangotango-theme syslog-mode syntactic-sugar synonyms svg-mode-line-themes sudoku ssh-config-mode ssh solarized-theme sokoban smex smart-tabs-mode smart-tab sicp shell-command sbt-mode roguel-ike reverse-theme restclient request rainbow-mode rainbow-delimiters python-info puppet-mode project-mode pretty-symbols-mode pretty-mode php-mode pcre2el pcmpl-args paredit nyan-mode nrepl nginx-mode neotree mustache-mode multiple-cursors multi-term maxframe markdown-mode lusty-explorer lorem-ipsum loop lolcode-mode logito lex langdoc lacarte jump ir-black-theme inf-ruby icomplete+ http-post-simple ht helm-themes haskell-mode gruber-darker-theme graphviz-dot-mode gotham-theme google-weather google-translate google-this go-mode git-blame fringe-helper fold-this fold-dwim-org flymake-shell flymake-python-pyflakes flymake-puppet flymake-haml flymake-cursor flymake flycheck-hdevtools find-things-fast find-file-in-git-repo erlang emacsd-tile elpy elisp-slime-nav edbi dizzee direx dired+ diminish delim-kill dash-functional colorsarenice-theme color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized chess change-inner bubbles browse-kill-ring bitlbee birds-of-paradise-plus-theme autopair auto-complete apache-mode anzu anaconda-mode ag ack-and-a-half abacus)))
 '(python-indent-offset 2)
 '(rainbow-identifiers-cie-l*a*b*-lightness 30)
 '(rainbow-identifiers-cie-l*a*b*-saturation 35)
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#eee8d5" 0.2))
 '(tab-stop-list (quote (2 4 6 8 10 12 16 18 20 22 24)))
 '(tab-width 2)
 '(term-default-bg-color "#fdf6e3")
 '(term-default-fg-color "#657b83")
 '(tool-bar-mode nil)
 '(tramp-default-method "ssh")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
	 (quote
		((20 . "#dc322f")
		 (40 . "#c85d17")
		 (60 . "#be730b")
		 (80 . "#b58900")
		 (100 . "#a58e00")
		 (120 . "#9d9100")
		 (140 . "#959300")
		 (160 . "#8d9600")
		 (180 . "#859900")
		 (200 . "#669b32")
		 (220 . "#579d4c")
		 (240 . "#489e65")
		 (260 . "#399f7e")
		 (280 . "#2aa198")
		 (300 . "#2898af")
		 (320 . "#2793ba")
		 (340 . "#268fc6")
		 (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
	 (quote
		(unspecified "#fdf6e3" "#eee8d5" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#657b83" "#839496"))))


;; wtf is this?
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'set-goal-column 'disabled nil)

;; allow mini buffer to shrink
(setq resize-mini-windows t)
(set-frame-parameter nil 'fullscreen 'nil)


;; start edit server
(when (require 'edit-server nil t)
	(setq edit-server-new-frame nil)
	(edit-server-start))

;; Check for shebang magic in file after save, make executable if found.
(defun hlu-make-script-executable ()
	"If file starts with a shebang, make `buffer-file-name' executable"
	(save-excursion
		(save-restriction
			(widen)
			(goto-char (point-min))
			(when (and (looking-at "^#!")
								 (not (file-executable-p buffer-file-name)))
				(set-file-modes buffer-file-name
												(logior (file-modes buffer-file-name) #o100))
				(message (concat "Made " buffer-file-name " executable"))
				))))

(add-hook 'after-save-hook 'hlu-make-script-executable)

;; for find dired
(setq find-args "-name .git -prune -o -name .svn -prune -o -type f ! -name '*class'")

;; install: regex thingies

(set-frame-parameter nil 'fullscreen 'fullboth)

;; for dired on os x
;; (setq ls-lisp-use-insert-directory-program t)
;; (setq insert-directory-program "gls")

(setq-default mode-line-format (append '(
																			;; mode-line-front-space
																			"	 =^..^=	 "
																			mode-line-mule-info
																			mode-line-client
																			mode-line-modified
																			mode-line-remote
																			mode-line-frame-identification
																			mode-line-buffer-identification
																			"		"
																			(vc-mode vc-mode)
																			mode-line-modes
																			"	 "
																			mode-line-position
																			mode-line-misc-info
																			mode-line-end-spaces
																			)
																	 ))

;; avoid ugly errors when focus leaves minibuffer
(defun stop-using-minibuffer ()
	"kill the minibuffer"
	(when (and (>= (recursion-depth) 1) (active-minibuffer-window))
		(abort-recursive-edit)))

(add-hook 'mouse-leave-buffer-hook 'stop-using-minibuffer)


(load "prog-modes.el")
(load "benhsu-keybindings.el")


;; dont pop up ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; copies string to
;; you can put anything that returns a string here
(defun to-clip (s) (with-temp-buffer (insert s) (clipboard-kill-ring-save (point-min) (point-max)) ))


(add-to-list 'tramp-default-user-alist
						 '("ssh" ".*\\.mcdc\\'" "bhsu"))

(set-default 'tramp-default-proxies-alist (quote (("localhost" "\\`root\\'" "/sudo:root@localhost:")
																									(".*" "\\`root\\'" "/ssh:bhsu@%h:"))))

(add-hook 'write-file-hooks 'delete-trailing-whitespace)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "White" :foreground "Black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "nil" :family "Monaco")))))


(put 'narrow-to-region 'disabled nil)
