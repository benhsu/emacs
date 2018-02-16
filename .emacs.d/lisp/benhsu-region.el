(defun join-all-lines () 
  (interactive)
  (progn 
    (let ((s (if (region-active-p)  (region-beginning) (point-min)))
          (e (if (region-active-p) (region-end) (point-max))))
      (goto-char s)
      (unwind-protect (end-of-line)
      (while (< (point) e)
        (next-line)
        (join-line)
        (end-of-line)
        )))))

 ;; used by collect-regexp-results, among others
(defun region-or-buffer-beginning ()
  ;;; returns region-beginning if region set, otherwise point-min
  (if (region-active-p) (region-beginning) (point-min)))

(defun region-or-buffer-end ()
  ;;; returns region-end if region set, otherwise point-max
  (if (region-active-p) (region-end) (point-max)))


;; shit to operate on a buffer or region

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))


(defun indent-line-or-region ()
  (interactive)
  (if (region-active-p)
      (indent-region (region-beginning) (region-end))
    (indent-region (line-beginning-position) (line-end-position))))


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


;; not sure if this works yet NOT DEAD JUST NOT ALIVE YET
;; make it over a region
;; body should do something to point
;; (defmacro over-buffer (body) (save-excursion ((goto-char (point-min)) (while (< (point) (point-max)) ,body))))

;;; SHIT BELOW IS NOT SORTED
;; from http://stackoverflow.com/questions/916797/emacs-global-set-key-to-c-tab
(global-set-key (kbd "<C-tab>") 'indent-line-or-region)

(local-set-key (kbd "\C-l") (lambda () (interactive) (fill-paragraph-or-region t)))


