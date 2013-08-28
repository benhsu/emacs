;;;; grrrrr this is all to get  tab complete to work in isearch
;;; I was going to bind tab to a "let list = this list, do dabbrev expand
;;; then i realized this wont work as typing in isearch is
;;; a special command, not  inserting text, so hippie expand wouldnt work

(defmacro loop-over-buffer (rest &rest resty)
  `(save-excursion (goto-char (point-min) 
                              )(while (< (point) (point-max))
                                ,rest ,resty
                                ))
  )

(defun strip-text-properties(txt)
  (set-text-properties 0 (length txt) nil txt)
      txt)



(defun words-for-buffer ()
  (let ((retval '()))
    (loop-over-buffer  
     (progn (forward-word) 
            (let ((cur (strip-text-properties (thing-at-point 'word)) ))
              (if cur (setq retval 
                  (cons cur retval) )))) )
    retval
    ))

(defun words-for-buffer (buffer)
  (with-current-buffer buffer
    (save-excursion
      (goto-char (point-min))
      (while (< (point) (point-max))))))

;; grrr, with-current-buffer is not a proper closure!

(defun try-expand-dabbrev-matching-buffers (old)
  (cl-flet ((buffer-list () (get-buffer "benhsu-functions.el")))
      (try-expand-dabbrev-all-buffers old)))


(setq hippie-expand-try-functions-list
      (list 'try-expand-dabbrev-matching-buffers ) 
                       )



;;;; end grre
