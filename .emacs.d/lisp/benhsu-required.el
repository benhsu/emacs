(require 'cl)
(require 's)
(require 'f)

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

(require 'midnight) ;;; PURGE at midnight
(require 'dired)
(require 'browse-kill-ring)
(require 'change-inner)
;; (require 'org)
(require 'ispell)
(require 'rainbow-delimiters)
(require 'lorem-ipsum)
;; (require 'multiple-cursors)
(require 'auto-complete)
(require 'wide-column)
(require 'ag)
(require 'diminish)
(require 'tramp)
(require 'thingatpt)
(require 'paredit)
(require 'neotree)
(require 'json-mode)
