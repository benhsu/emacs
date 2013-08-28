(require 'cl)

;;uniquify makes your buffers unique. Its useful when I work with several pom.xml's
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;re builder is a regexp builder
;;reb-re-syntax=string means we dont need to double quote a backslash
(require 're-builder)
(setq reb-re-syntax 'string)

;; smex is M-x with completion
(require 'smex)
(smex-initialize)

(require 'nyan-mode)
(nyan-mode)
(setcar mode-line-format "  =^..^=")
(setcar mode-line-format '(:eval (substring
                (system-name) 0 (string-match "\\..+" (system-name)))))

;;; PURGE at midnight

(require 'midnight)
(require 'google-this)
(require 'dired)
(require 'reddit)  
(require 'browse-kill-ring)
(require 'change-inner)
(require 'org)
(require 'ispell)
(require 'rainbow-delimiters)
(require 's)
(require 'f)
(require 'lorem-ipsum)
;; (require 'multiple-cursors)
(require 'auto-complete)
(require 'wide-column)
(require 'gnus)
(require 'gmail-notifier)
(require 'ag)
(require 'diminish)
;; (require 'pcmpl-args)
;;; (require 'cssh)


;;require 'multi-term)

;;interactive do mode
;;require 'ido)

;;require 'expand-region)

;;(require 'minimap)

;; (require 'key-chord)
;;(key-chord-mode 1)

;;require 'highlight-indentation)

