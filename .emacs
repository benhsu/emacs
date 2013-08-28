
;; with apologies to the USMC:
;; this is my .emacs, there are many like it but this one is mine.
;; My emacs is my best friend. It is my life. I must master it as I must master my life.
;; My emacs, without me, is useless. Without my emacs, I am useless. 

;;  Emacs is to Eclipse as a light saber is to a blaster — but a blaster is a lot easier for anyone to pick up and use -- yegge
;;     "your fathers .emacs, an elegant weapon, for a more civilised age" ;; i am reminded of the story of the third-generation emacs user
;; ;;  actually I think vim is the lightsaber (the more elegant weapon), emacs is more like the cosmic cube or green lantern ring

;; from http://stackoverflow.com/questions/658095/what-is-the-best-emacs-book-out-there 
;; "You will never find a definitive Emacs book. Emacs arcana are passed on from druid to druid in the dead of night, 
;; using much ritual and gnashing of teeth."


;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)

;; set the load path

(let ((default-directory  "~/.emacs.d/"))
  (normal-top-level-add-subdirs-to-load-path))

(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.site.d/")

;; path for unix utils
;; why is there a quote here? copy and pasted this when I didnt know what I was doing
(setq exec-path '("/Users/benhsu/bin" "/opt/local/bin" "/Users/benhsu/.rvm/gems/ruby-1.9.3-p327/bin" "/Users/benhsu/.rvm/gems/ruby-1.9.3-p327@global/bin" "/Users/benhsu/.rvm/rubies/ruby-1.9.3-p327/bin" "/Users/benhsu/.rvm/bin" "/usr/bin" "/bin" "/usr/sbin" "/sbin" "/usr/local/bin" "/opt/X11/bin" "/Users/benhsu/grails-1.2.1/bin") )


;; above seems to not work for gimme-cat
(setenv "PATH" (concat "/Users/benhsu/bin:" "/opt/local/bin:/opt/local/sbin:/usr/local/bin:" (getenv "PATH")))

;; from http://technical-dresese.blogspot.com/2012/12/encrypted-emacs-customizations.html
(add-to-list 'load-suffixes ".el.gpg")
(load "secrets.el.gpg" )

;; where we keep mysql passwords, separate file not in github
;; the "1" means dont throw an error if its not found
(load "passwords.el" 1)

;; put all my 'require's here
(load "benhsu-required.el")
(load "benhsu-functions.el")

;; (unless (require 'el-get nil t)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (goto-char (point-max))
;;     (eval-print-last-sexp)))
;; ;;; begin elget
;; (add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; ;; now either el-get is `require'd already, or have been `load'ed by the
;; ;; el-get installer.
;; (setq
;;  el-get-sources
;;  '(el-get				; el-get is self-hosting
;;    escreen            			; screen for emacs, C-\ C-h
;;    php-mode-improved			; if you're into php...
;;    switch-window			; takes over C-x o
;;    auto-complete			; complete as you type with overlays
;;    zencoding-mode			; http://www.emacswiki.org/emacs/ZenCoding

;;    (:name buffer-move			; have to add your own keys
;;           :after (lambda ()
;;                    (global-set-key (kbd "<C-S-up>")     'buf-move-up)
;;                    (global-set-key (kbd "<C-S-down>")   'buf-move-down)
;;                    (global-set-key (kbd "<C-S-left>")   'buf-move-left)
;;                    (global-set-key (kbd "<C-S-right>")  'buf-move-right)))

;;    (:name smex				; a better (ido like) M-x
;;           :after (lambda ()
;;                    (setq smex-save-file "~/.emacs.d/.smex-items")
;;                    (global-set-key (kbd "M-x") 'smex)
;;                    (global-set-key (kbd "M-X") 'smex-major-mode-commands)))

;;    (:name magit				; git meet emacs, and a binding
;;           :after (lambda ()
;;                    (global-set-key (kbd "C-x C-z") 'magit-status)))

;;    (:name goto-last-change		; move pointer back to last change
;;           :after (lambda ()
;;                    ;; when using AZERTY keyboard, consider C-x C-_
;;                    (global-set-key (kbd "C-x C-/") 'goto-last-change))))
;;  )

;; ;; 	do (add-to-list 'el-get-sources p)))
;; (setq el-get-user-package-directory "~/.emacs.d/packages.d/")

;; (el-get 'sync)

;; start emacs server
(server-start)

(display-time)

;; load part of file

;; run a shell command in archive mode

(defun list-buffers-hotkey ()
  (interactive)
  (progn (list-buffers)
         (switch-to-buffer "*Buffer List*")))

;; truncate the buffer

(add-hook 'comint-output-filter-functions
          'comint-truncate-buffer)

(if (or (eq window-system 'x) (eq window-system 'ns))
    (set-default-font "Inconsolata-16")
  )
(set-variable 'cursor-type 'box)

;; open *help* in current frame for `one-buffer-one-frame-mode'
;;setq obof-other-frame-regexps (remove "\\*Help\\*" obof-other-frame-regexps))
;;add-to-list 'obof-same-frame-regexps "\\*Help\\*")
;;add-to-list 'obof-same-frame-switching-regexps "\\*Help\\*")

;; open *help* in current frame
;; disabling now that i know 'z' kills the buffer
;; (setq special-display-regexps (remove "[ ]?\\*[hH]elp.*" special-display-regexps))

;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t))
;;;;While we are at it, always flash for parens.
(show-paren-mode 1)
(winner-mode 1)

;; enable visual feedback on selections
;;setq transient-mark-mode t)
;;(setq line-move-visual nil)
(visual-line-mode 1)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" system-name))
(setq inhibit-startup-message t)

(setq fill-column 120)
(setq c-basic-offset 4)
(setq-default indent-tabs-mode nil)
(setq-default indent-line-function 'insert-tab)
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



(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(defalias 'yes-or-no-p 'y-or-n-p)

;;;;Change backup behavior to save in a directory, not in a miscellany
;;;;of files all over the place.
(setq
 backup-by-copying t      ; don't clobber symlinks
 backup-directory-alist
 '(("." . "~/.saves"))    ; don't litter my fs tree
 delete-old-versions t
 kept-new-versions 6
 kept-old-versions 2
 version-control t)       ; use versioned backups

;; change location of the "#" files
(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;; do I want this or org mode or lisp mode

(setq default-major-mode 'text-mode)

(defmacro lambdaste (rest) `(lambda () ,rest))

(add-hook 'text-mode-hook (lambdaste (flyspell-mode 1)))
(add-hook 'text-mode-hook (lambdaste (visual-line-mode 1)))
(add-hook 'text-mode-hook (lambdaste (rainbow-delimiters-mode 1)))

(add-hook 'org-mode-hook (lambdaste (flyspell-mode 1)))
(add-hook 'org-mode-hook (lambdaste (visual-line-mode 1)))
(add-hook 'org-mode-hook (lambdaste (rainbow-delimiters-mode 1)))


;;;Text files supposedly end in new lines. Or they should.
;;setq require-final-newline t)

;;;;This sets garbage collection to hundred times of the default.
;;;;Supposedly significantly speeds up startup time. (Seems to work
;;;;for me,  but my computer is pretty modern. Disable if you are on
;;;;anything less than 1 ghz).
(setq gc-cons-threshold 50000000)

;;;;Use ANSI colors within shell-mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;;interpret and use ansi color codes in shell output windows
(ansi-color-for-comint-mode-on)

;; for compiling!

;;do not split the window for "compilation" or "backtrace" (eLISP compilation error)
;;make the new window as wide as possible
;;this regexp is from (regexp-opt '("*compilation*" "*Backtrace*" "*Apropos*" "*Occur*")))
;; (setq same-window-regexps '("\\(?:\\*\\(?:\\(?:Apropos\\|Backtrace\\|Occur\\|compilation\\|Help\\|nrepl\\)\\*\\)\\)"))
(setq same-window-regexps '())

;; (setq split-width-threshold nil)
;;(setq split-height-threshold 1000)

;;;;;;;;;;;;;;;;;;; below this is for reference
;; run a few shells.
;;(shell "*shell5*")
;;(shell "*shell6*")
;;(shell "*shell7*")

;;bind enter to insert instead of visit

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
(setq whitespace-display-mappings
      '(
        (space-mark 32 [183] [46]) ; normal space, ·
        (space-mark 160 [164] [95])
        (space-mark 2208 [2212] [95])
        (space-mark 2336 [2340] [95])
        (space-mark 3616 [3620] [95])
        (space-mark 3872 [3876] [95])
        (newline-mark 10 [182 10]) ; newlne, ¶
        (tab-mark 9 [9655 46] ) ; tab, ▷
        ))

;;;;;; stuff for mysql
;; moved to another file because I did not want passwords in github :)
;; (setq sql-connection-alist
;;       '((db-name
;;          (sql-product 'mysql)
;;          (sql-server "IP")
;;          (sql-user "")
;;          (sql-password "")
;;          (sql-database "")
;;          (sql-port 3306))

;;from sacha chua, add package manager if version si 24
(if (string-match " 24" (version))
    (progn
      (package-initialize)
      ;; Add the original Emacs Lisp Package Archive
      (add-to-list 'package-archives
                   '("gnu" . "http://elpa.gnu.org/packages/"))
      (add-to-list 'package-archives
                   '("melpa" . "http://melpa.milkbox.net/packages/") t)
      ;; (add-to-list 'package-archives
      ;;              '("elpa" . "http://tromey.com/elpa/"))
      ;; ;; Add the user-contributed repository
      ;; (add-to-list 'package-archives
      ;;              '("marmalade" . "http://marmalade-repo.org/packages/"))
))


;;; these are some packages

;;set up locate to use new thingie
(defun my-locate-make-command-line (arg)
  (interactive)
  (list "mdfind" arg))

;;set the 'locate' command to use emacs
;; (setq locate-command "locate")
;; (defun locate-make-command-line (search-string)
;;   (list "/opt/local/libexec/gnubin/locate" "--regex" search-string))

(setq locate-make-command-line 'my-locate-make-command-line)
(defvar locate-history nil "History for locate")


(defun locate-remember (search-string)
  "calls locate, but remembers the last thing searched for"
  (interactive (list (read-from-minibuffer "Locate: " (car locate-history) nil nil 'locate-history)))
  (locate search-string))


;;from http://tsdh.wordpress.com/2008/08/20/re-open-read-only-files-as-root-automagically/
;;open read only as root
;; (defun th-rename-tramp-buffer ()
;;   (when (file-remote-p (buffer-file-name))
;;     (rename-buffer
;;      (format "%s:%s"
;;              (file-remote-p (buffer-file-name) 'method)
;;              (buffer-name)))))

;; (add-hook 'find-file-hook
;;           'th-rename-tramp-buffer)

(require 'tramp)
(tramp-set-completion-function "ssh"
           '((tramp-parse-hosts "/etc/hosts")
             (tramp-parse-sconfig "/etc/ssh_config")
             (tramp-parse-sconfig "~/.ssh/config")))

;; add remote sudo          
;; (add-to-list 'tramp-default-proxies-alist
;;              '(nil "\\`root\\'" "/ssh:%h:"))

;; (add-to-list 'tramp-default-proxies-alist
;;              '((regexp-quote (system-name)) nil nil))

;; (defadvice find-file (around th-find-file activate)
;;   "Open FILENAME using tramp's sudo method if it's read-only."
;;   (if (and (not (file-writable-p (ad-get-arg 0)))
;;            (y-or-n-p (concat "File "
;;                              (ad-get-arg 0)
;;                              " is read-only.  Open it as root? ")))
;;       (th-find-file-sudo (ad-get-arg 0))
;;     ad-do-it))

;; (defun th-find-file-sudo (file)
;;   "Opens FILE with root privileges."
;;   (interactive "F")
;;   (set-buffer (find-file (concat "/sudo::" file))))

;;defun minimap-large-files()
;; (when (>= (count-lines (point-min) (point-max)) 100)
;;   (minimap-create)))

;; (defun minimap-large-files())

;;(add-hook 'find-file-hook
;;          'minimap-large-files)

;;add-hook 'dired-hook (lambda () (define-key (kbd "RED") 'dired-maybe-insert-subdir)))
;;require 'dired+)
;; now define "o" to open
;; bug! dired needs to be loaded for this to work!
;; (require 'dired) ;; see if this fixes it
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
  (require 'dired)
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

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(jabber-title-large ((t (:inherit variable-pitch :weight bold :height 1.0 :width normal))))
 '(jabber-title-medium ((t (:inherit variable-pitch :weight bold :height 1.0 :width normal))))
 '(jabber-title-small ((t (:inherit variable-pitch :weight bold :height 1.0 :width normal)))))

;; I think custom set variables needs to be down here, after the custom packages (nyan mode)
;; are loaded
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Linum-format "%7i ")
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector ["#000000" "#ff0000" "#00ff00" "#ffff00" "#0000ff" "#dc8cc3" "#93e0e3" "#dcdccc"])
 '(ansi-term-color-vector [unspecified "#1F1611" "#660000" "#144212" "#EFC232" "#5798AE" "#BE73FD" "#93C1BC" "#E6E1DC"] t)
 '(auth-source-save-behavior nil)
 '(background-color "#042028")
 '(background-mode dark)
 '(column-number-mode t)
 '(comint-buffer-maximum-size 100000000)
 '(comint-completion-addsuffix t)
 '(comint-completion-autolist t)
 '(comint-input-ignoredups t)
 '(comint-move-point-for-output t)
 '(comint-scroll-show-maximum-output t)
 '(comint-scroll-to-bottom-on-input nil)
 '(compilation-scroll-output t)
 '(cursor-color "#708183")
 '(custom-safe-themes (quote ("2611d548a133727b1a956c4fa262935e993662a0aaa25d9532b04ab8f556a25b" "f81e1ca8cefb9d4ded877d39f082c812294bcac41fce5be7230caa6cc83bde37" "2b80b8864ae9fa004bf55bb6d30bb948621f85eb23ee80a1d7bf071d0e4b51e1" "830a42aead6991df6cbd626faa73ba3fe5513944c6bb63cdc1b57e003424f0f2" "fa189fcf5074d4964f0a53f58d17c7e360bb8f879bd968ec4a56dc36b0013d29" "d971315c813b0269a86e7c5e73858070063016d9585492bd8d0f27704d50fee7" "4be0cb1919fc15bfb879960ac270da77bf8a5d162fd2b4db7ce8969d188eeb3a" "fc6e906a0e6ead5747ab2e7c5838166f7350b958d82e410257aeeb2820e8a07a" "b1cbf9910beb0e3655a779d1d4db5b4892a9e9968c7166be2c3f4c6574055fa8" "b8d292bcaa96314802968d86ac2e6df5f49dbb3ba6ae47207686efcc8a4e687a" "04643edb183240f680d5465cf9e9ac3037086f701df09ce5d9183e6c69e73a7e" "0f5a0663ba56e3342d5d798d0008bc25105c6bf1bb46ef307b6509a80f084291" "978bd4603630ecb1f01793af60beb52cb44734fc14b95c62e7b1a05f89b6c811" "764777857ef24b4ef1041be725960172ac40964b9f23a75894a578759ba6652f" "c377a5f3548df908d58364ec7a0ee401ee7235e5e475c86952dc8ed7c4345d8e" "65510ff6bb3cddeb9fcdc61770abcb8cbf8a15185a0b268f77c6b515650a625b" "65f7173faa84a97044d743d4bab115a6ab52bc6e6dc47612e31e4dbc39ebb1ae" "c7359bd375132044fe993562dfa736ae79efc620f68bab36bd686430c980df1c" "6f3060ac8300275c990116794e1ba897b6a8af97c51a0cb226a98759752cddcf" "d627f82b34aa8386eb8d3cfecd4be52d1409bf0e78b86db693b1d093c83160c1" "8874901e0011a7b07e546b65be1726c4cc3f35cf1a60f8805e6cb5bb59ba305c" "dc46381844ec8fcf9607a319aa6b442244d8c7a734a2625dac6a1f63e34bc4a6" "d0ff5ea54497471567ed15eb7279c37aef3465713fb97a50d46d95fe11ab4739" "a5a1e3cd5f790846f4eec5fcff52935e5ef6d713a0f9342fef12eccfd9e9eff0" "3555946b490880a78bdfc343fd596e29f9aa9f035b2e73bb11d0bc9f85facbe7" "a234f91f9be6ed40f6ce0e94dce5cea1b9f1ccec2b9ccd42bb71c499867a3fcc" "c9d00d43bd5ad4eb7fa4c0e865b666216dfac4584eede68fbd20d7582013a703" "752b605b3db4d76d7d8538bbc6fe8828f6d92a720c0ea334b4e01cea44d4b7a9" "9b1fef323a27cb0d6c5ad18c55655aa19986b27beef57feeb0340b07f925cc0f" "3d6b08cd1b1def3cc0bc6a3909f67475e5612dba9fa98f8b842433d827af5d30" "1cf3f29294c5a3509b7eb3ff9e96f8e8db9d2d08322620a04d862e40dc201fe2" "1c1e6b2640daffcd23b1f7dd5385ca8484a060aec901b677d0ec0cf2927f7cde" "8c5ffc9848db0f9ad4e296fa3cba7f6ea3b0e4e00e8981a59592c99d21f99471" "e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "1a093e45e4c3e86fa5ad1f8003660e7cda4d961cd5d377cee3fee2dad2faf19b" "7bc53c2f13ad0de4f1df240fde8fe3d5f11989944c69f9e02f2bd3da9ebbdcd9" "3c708b84612872e720796ea1b069cf3c8b3e909a2e1da04131f40e307605b7f9" "77bd459212c0176bdf63c1904c4ba20fce015f730f0343776a1a14432de80990" "c1fb68aa00235766461c7e31ecfc759aa2dd905899ae6d95097061faeb72f9ee" "7feeed063855b06836e0262f77f5c6d3f415159a98a9676d549bfeb6c49637c4" "d407116c7044db837e7f2df1e6e066941a370c60ce5ac92b4929e2b4ea6e3f6a" "65e05a8630f98308e8e804d3bbc0232b02fe2e8d24c1db358479a85f3356198d" "ea0c5df0f067d2e3c0f048c1f8795af7b873f5014837feb0a7c8317f34417b04" "75d4ccc5e912b93f722e57cca3ca1a15e079032cd69fd9bc67268b4c85639663" "e53cc4144192bb4e4ed10a3fa3e7442cae4c3d231df8822f6c02f1220a0d259a" "de2c46ed1752b0d0423cde9b6401062b67a6a1300c068d5d7f67725adc6c3afb" "f41fd682a3cd1e16796068a2ca96e82cfd274e58b978156da0acce4d56f2b0d5" "978ff9496928cc94639cb1084004bf64235c5c7fb0cfbcc38a3871eb95fa88f6" "41b6698b5f9ab241ad6c30aea8c9f53d539e23ad4e3963abff4b57c0f8bf6730" "405fda54905200f202dd2e6ccbf94c1b7cc1312671894bc8eca7e6ec9e8a41a2" "1affe85e8ae2667fb571fc8331e1e12840746dae5c46112d5abb0c3a973f5f5a" "9bac44c2b4dfbb723906b8c491ec06801feb57aa60448d047dbfdbd1a8650897" "24cb1b9c182198f52df7cebf378ee9ecca93a2daeb9a90049a2f1f556119c742" "7df1ccf73c0e12f97a91aaf5fed6a7594b154137190f4ab3232b3cbc42bc9052" "88d556f828e4ec17ac074077ef9dcaa36a59dccbaa6f2de553d6528b4df79cbd" "5f7044d9fc9c9c9d56508ac8217483c8358a191599448859640ce80be92acbd6" "ad63a0dfb8bd5d4c0c7015e851a09283ff050b8df37d2ffe2028be77ff446119" "d1a574d57027c2bfadde6982455dfce8d27ced3ae4747c1c0313f95d23e96713" "d5b63a5da8bf90c7347e5e484dcde0380af010ec130f6f0d132113d807e49e03" "ff7a12f1932abcdc754511b5c5c6416e769d7f1a44e64690e2c98433b18bd67e" "38c4fb6c8b2625f6307f3dde763d5c61d774d854ecee9c5eb9c5433350bc0bef" "885c87a0f8e1cff0eb20eb93a495d307f8c70e13a9f4fa238d2897da1081107b" "47d2a01f2cbd853ccd1eddcb0e9e4fdfdabcc97ddad1d1a5218304294889f731" "bf8d07f24b40cb71bb2ffb56b2df537eda5101cb6c4322ba1741e29290cc260b" "085f323fe46529bf4526eaf7b5ae8dfb87415a68150db71a60a86c2e44329923" "4ddc42a539280ec21ae202b6c12a4d7ce7d7af8a19e8c344b60b09f1ca1496d5" "f5e56ac232ff858afb08294fc3a519652ce8a165272e3c65165c42d6fe0262a0" "3dd173744ae0990dd72094caef06c0b9176b3d98f0ee5d822d6a7e487c88d548" "998e84b018da1d7f887f39d71ff7222d68f08d694fe0a6978652fb5a447bdcd2" "36a309985a0f9ed1a0c3a69625802f87dee940767c9e200b89cdebdb737e5b29" "edb4ea9f96208f1691d6a6ebb70498257d1466058f7907ac0f4966da101101e2" "ae8d0f1f36460f3705b583970188e4fbb145805b7accce0adb41031d99bd2580" "51bea7765ddaee2aac2983fac8099ec7d62dff47b708aa3595ad29899e9e9e44" "59ca3bdc375679bf027d0cdebb1ececd35e8892d4e259ed9c7188054bac5f3ad" "22d24b0e5c7cd65b172770c8bebebd3bcdd52fca59269525533aa851f03f888c" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "8281168b824a806489ca7d22e60bb15020bf6eecd64c25088c85b3fd806fc341" "5e1d1564b6a2435a2054aa345e81c89539a72c4cad8536cfe02583e0b7d5e2fa" "f38dd27d6462c0dac285aa95ae28aeb7df7e545f8930688c18960aeaf4e807ed" "6cfe5b2f818c7b52723f3e121d1157cf9d95ed8923dbc1b47f392da80ef7495d" "fca8ce385e5424064320d2790297f735ecfde494674193b061b9ac371526d059" "159bb8f86836ea30261ece64ac695dc490e871d57107016c09f286146f0dae64" "e9a1226ffed627ec58294d77c62aa9561ec5f42309a1f7a2423c6227e34e3581" "944f3086f68cc5ea9dfbdc9e5846ad91667af9472b3d0e1e35a9633dcab984d5" "8b49009d04730bc5d904e7bb5c7ff733f3f9615c3d6b3446eca0766e6da2bea1" "27b53b2085c977a8919f25a3a76e013ef443362d887d52eaa7121e6f92434972" "967c58175840fcea30b56f2a5a326b232d4939393bed59339d21e46cf4798ecf" "6bc195f4f8f9cf1a4b1946a12e33de2b156ce44e384fbc54f1bae5b81e3f5496" "3f1540a9b55ba2db89ff9247e69c4aa533651bbef165fb80ef7c1ee2f1b3f4f7" "9448a3998a7eae068ac10c9f249bd032d5c36661070d1f565a23b10f422fa2fe" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "211bb9b24001d066a646809727efb9c9a2665c270c753aa125bace5e899cb523" "c56fd34f8f404e6e9e6f226c6ce2d170595acc001741644d22b49e457e3cd497" "5cb805901c33a175f7505c8a8b83c43c39fb84fbae4e14cfb4d1a6c83dabbfba" "9dcaa85098f150e36b9af820292db0d42f7c4129ca58b55927fbebdcbcf2fa98" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "71efabb175ea1cf5c9768f10dad62bb2606f41d110152f4ace675325d28df8bd" "27470eddcaeb3507eca2760710cc7c43f1b53854372592a3afa008268bcf7a75" "6615e5aefae7d222a0c252c81aac52c4efb2218d35dfbb93c023c4b94d3fa0db" default)))
 '(debug-on-error t)
 '(fci-rule-character-color "#452E2E")
 '(fci-rule-color "#202020")
 '(fill-column 130)
 '(foreground-color "#708183")
 '(frame-brackground-mode (quote dark))
 '(fringe-mode 4 nil (fringe))
 '(ido-ignore-directories (quote ("\\`CVS/" "\\`\\.\\./" "\\`\\./" "\\`\\.svn/")))
 '(ido-mode (quote both) nil (ido))
 '(ido-show-dot-for-dired t)
 '(jabber-auto-reconnect t)
 '(jabber-roster-line-format " %c %-25n %u %-8s  %S")
 '(jabber-roster-show-title nil)
 '(jabber-show-resources nil)
 '(large-file-warning-threshold 50000000)
 '(line-number-mode t)
 '(linum-format " %6d ")
 '(main-line-color1 "#1e1e1e")
 '(main-line-color2 "#111111")
 '(main-line-separator-style (quote chamfer))
 '(max-specpdl-size 50000)
 '(menu-bar-mode nil)
 '(mumamo-chunk-coloring 1)
 '(nxml-sexp-element-flag t)
 '(nyan-animate-nyancat t)
 '(nyan-bar-length 32)
 '(nyan-wavy-trail t)
 '(org-special-ctrl-a/e t)
 '(powerline-color1 "#1e1e1e")
 '(powerline-color2 "#111111")
 '(show-paren-mode t)
 '(tab-stop-list (quote (2 4 6 8 10 12 16 18 20 22 24)))
 '(tab-width 2)
 '(tool-bar-mode nil)
 '(tramp-default-method "ssh")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#cc6666") (40 . "#de935f") (60 . "#f0c674") (80 . "#b5bd68") (100 . "#8abeb7") (120 . "#81a2be") (140 . "#b294bb") (160 . "#cc6666") (180 . "#de935f") (200 . "#f0c674") (220 . "#b5bd68") (240 . "#8abeb7") (260 . "#81a2be") (280 . "#b294bb") (300 . "#cc6666") (320 . "#de935f") (340 . "#f0c674") (360 . "#b5bd68"))))
 '(vc-annotate-very-old-color nil))



(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; allow mini buffer to shrink
(setq resize-mini-windows t)
;; (set-frame-parameter nil 'fullscreen 'fullboth)
(set-frame-parameter nil 'fullscreen 'nil)

;; org mode
(setq org-default-notes-file "~/Dropbox/withwork/notes.org")
(define-key global-map (kbd "s-.") 'org-capture)

;; add org habit
;;(add-to-list 'org-modules 'org-habit)

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/Dropbox/withwork/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("e" "emacs hackery" entry (file "~/Dropbox/withwork/emacs.org" )
         "* TODO %?\n")
        ("w" "work" entry (file "~/Dropbox/withwork/work.org" )
         "* TODO %?\n")
        ("o" "notes for marty" entry (file "~/Dropbox/withwork/marty.org" )
         "* %t %?\n")
        ("r" "rants" entry (file "~/Dropbox/withwork/rants.org" )
         "*  %?\n")
        ("m" "movies and shows" entry (file "~/Dropbox/withwork/movies.org" )
         "* TODO %?\n")
        ("j" "Journal" entry (file+datetree "~/Dropbox/withwork/journal.org")
         "* %U\n  %?")))

(setq org-todo-keywords
      '((sequence "TODO" "|" "DONE" "FLOODED")))

;; (setq org-agenda-files '("~/Dropbox/withwork/emacs.org"))

(setq org-refile-targets
      '(
        ("~/Dropbox/withwork/emacs.org" :tag . "emacs")
        ("~/Dropbox/withwork/movies.org" :tag . "movie")
        ("~/Dropbox/withwork/movies.org" :tag . "comics")
        ))

  ;; - a cons cell (:tag . "TAG") to identify refile targets by a tag.
  ;;   This tag has to be present in all target headlines, inheritance will
  ;;   not be considered.

;; (setq ispell-local-dictionary-alist                                     
;;       '(("en_US"  
;;          "[A-Za-z]"  ;; case chars
;;          "[^A-Za-z]" ;; not case chars
;;          "[']"  t  
;;          ("-d"  "en_US")  nil  utf-8)) )

;; (setq ispell-program-name (executable-find "hunspell")
;;       ispell-really-hunspell t
;;       ispell-dictionary "en_US"
;; )

;; (setq ispell-current-dictionary "en_US")

;; (ispell-init-process)


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

(provide 'interpolate)

;; for find dired
(setq find-args "-name .git -prune -o -name .svn -prune -o -type f ! -name '*class'")

;; install: regex thingies

(set-frame-parameter nil 'fullscreen 'fullboth)
(unicode-fonts-setup)
(jabber-connect-all)
(gmail-notifier-start)

(put 'set-goal-column 'disabled nil)

(setq gnus-select-method '(nnimap "gmail"
				  (nnimap-address "imap.gmail.com")
				  (nnimap-server-port 993)
				  (nnimap-stream ssl)))

(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "bhsu@criticalmention.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587
      smtpmail-local-domain "gmail.com")

;; (load "benhsu-theme.el")

;; for dired on os x
(setq ls-lisp-use-insert-directory-program t)
(setq insert-directory-program "gls")


(use-theme 'monokai)
(setq-default mode-line-format (append '( 
                                      ;; mode-line-front-space 
                                      "  =^..^=  "   
                                      mode-line-mule-info 
                                      mode-line-client 
                                      mode-line-modified 
                                      mode-line-remote 
                                      mode-line-frame-identification 
                                      mode-line-buffer-identification 
                                      "   " 
                                      (vc-mode vc-mode)
                                      mode-line-modes 
                                      (:eval (symbol-name used-theme))
                                      "  " 
                                      mode-line-position
                                      mode-line-misc-info 
                                      mode-line-end-spaces
                                      ) 
                                   ))

(global-set-key (kbd "M-/") 'hippie-expand)

(setq hippie-expand-try-functions-list '(try-complete-lisp-symbol-partially 
                                         try-complete-lisp-symbol
                                         try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers 
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially 
                                         try-complete-file-name
                                         try-expand-all-abbrevs 
                                         try-expand-list 
                                         try-expand-line
                                         ))


(load "prog-modes.el")
(load "benhsu-keybindings.el")


;; (require 'svg-mode-line-themes)
;; (smt/enable)
;; (smt/set-theme 'black-crystal)

;; (set-face-attribute 'mode-line nil :box nil)
;;(set-face-attribute 'mode-line-inactive nil :box nil)



(require 'edit-server nil t)



;; from http://bc.tech.coop/blog/070424.html
(setq slime-output-buffer "*inferior-lisp*" )
(defun slime-output-buffer ()
slime-output-buffer)
(defun slime-send-dwim (arg)
  "Send the appropriate forms to CL to be evaluated."
  (interactive "P")
  (save-excursion
    (cond 
      ;;Region selected - evaluate region
      ((not (equal mark-active nil))
       (copy-region-as-kill (mark) (point)))
      ;; At/before sexp - evaluate next sexp
      ((or (looking-at "\s(")
	   (save-excursion
	     (ignore-errors (forward-char 1))
	     (looking-at "\s(")))
       (forward-list 1)
       (let ((end (point))
	     (beg (save-excursion
		    (backward-list 1)
		    (point))))
	 (copy-region-as-kill beg end)))
      ;; At/after sexp - evaluate last sexp
      ((or (looking-at "\s)")
	   (save-excursion
	     (backward-char 1)
	     (looking-at "\s)")))
       (if (looking-at "\s)")
	   (forward-char 1))
       (let ((end (point))
	     (beg (save-excursion
		    (backward-list 1)
		    (point))))
	 (copy-region-as-kill beg end)))
      ;; Default - evaluate enclosing top-level sexp
      (t (progn
	   (while (ignore-errors (progn
				   (backward-up-list)
				   t)))
	   (forward-list 1)
	   (let ((end (point))
		 (beg (save-excursion
			(backward-list 1)
			(point))))
	     (copy-region-as-kill beg end)))))
    (set-buffer (slime-output-buffer))
    (unless (eq (current-buffer) (window-buffer))
      (pop-to-buffer (current-buffer) t))
    (goto-char (point-max))
    (yank)
    (if arg (progn
	      (slime-repl-return)
	      (other-window 1)))))

;;; try out workgroups mode

(require 'workgroups)
(setq wg-prefix-key (kbd "C-c w"))
(workgroups-mode 1) 

;; dont pop up ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; (defmacro clear-variable (varname) (setq varname nil)
;; )

(defadvice ido-find-file (after find-file-sudo activate)
  "Find file as root if necessary."
  (if (and buffer-file-name (not (file-writable-p buffer-file-name)))
      (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;; add ALL the themes to load path even if they're not there
(mapcar (lambda (f) (add-to-list 'custom-theme-load-path f))  (remove-if-not (lambda (f) (s-contains-p "theme" f)) load-path))

(diminish 'paredit-mode "par")
(diminish 'elisp-slime-nav-mode "el-nav")
