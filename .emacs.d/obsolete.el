;; obsolete, but it taugjt me such useful things as 'locate-file and (read (current-buffer))
(defun file-sexps-list (file-name)
  (let ((file-sexps nil))
    ;; Keep reading Lisp expressions, until we hit EOF,
    ;; and just add one entry for each toplevel form
    ;; to `file-forms'.
    (condition-case err
        (with-temp-buffer
          (insert-file file-name)
          (goto-char (point-min))
          (while (< (point) (point-max))
            (let* ((sexp (read (current-buffer)))
                   )
              (setq file-sexps (cons sexp file-sexps)))))
      (end-of-file nil))
    (reverse file-sexps)))

(defun find-in-tree 
  (pred sexp) 
  (progn
    ;; (message (format "%s" sexp) )
    (remove-if-not 
     (lambda (x) x) 
     (mapcar (lambda (x) 
               (cond 
                ((funcall pred x ) (progn (message (format "s" x)) x)) 
                ((and (listp x) (eq (type-of (cdr x)) 'cons)) (find-in-tree pred x)) ;; listp doesnt quite work for cons cells: (a . b)
                (t nil))) sexp))))


