;; code to make working with windows easier


;; for now just collect stuff
;; eventually we want to save window configs, and bind certain buffers to certain windows

(winner-mode 1)


;;do not split the window for "compilation" or "backtrace" (eLISP compilation error)
;;make the new window as wide as possible
;;this regexp is from (regexp-opt '("*compilation*" "*Backtrace*" "*Apropos*" "*Occur*")))
;; (setq same-window-regexps '("\\(?:\\*\\(?:\\(?:Apropos\\|Backtrace\\|Occur\\|compilation\\|Help\\|nrepl\\)\\*\\)\\)"))
(setq same-window-regexps '())

;; (setq split-width-threshold nil)
;;(setq split-height-threshold 1000)

(global-set-key (kbd  "C-s-n") 'scroll-other-window)
(global-set-key (kbd  "C-S-s-v") 'scroll-other-window-down)

;;; try out workgroups mode

(require 'workgroups)
(setq wg-prefix-key (kbd "C-c w"))
(workgroups-mode 1) 

(defvar window-configurations '())
(defun push-windows ()
  (interactive)
  (setq window-configurations (cons (current-window-configuration) window-configurations))
  )

(defun pop-windows ()
  (interactive)
  (set-window-configuration (pop window-configurations))
  )

(defun clear-windows ()
  (push-windows)
  (delete-other-windows))

;;; WINDOW SPLITING
;;; from http://xahlee.org/emacs/effective_emacs.html
(global-set-key (kbd "M-3") 'split-window-horizontally) ; was digit-argument
(global-set-key (kbd "M-4") 'split-window-vertically) ; was digit-argument
(global-set-key (kbd "M-1") 'delete-other-windows) ; was digit-argument
(global-set-key (kbd "M-k") 'other-window) ; was center-line

(global-set-key (kbd "s--") 'split-window-below)
(global-set-key (kbd "s-=") 'split-window-right)

;; (make-key "<s-S-left>" global-map (windmove-left))
;; (make-key "<s-S-right>" global-map (windmove-right))
;; (make-key "<s-S-up>" global-map (windmove-up))
;; (make-key "<s-S-down>" global-map (windmove-down))
(global-set-key (kbd  "<s-backspace>") 'winner-undo)
(global-set-key (kbd  "<S-s-backspace>") 'winner-redo)

;;I hate using C-x 1 to delete other window
(global-set-key (kbd "C-M-w") 'delete-other-windows)




