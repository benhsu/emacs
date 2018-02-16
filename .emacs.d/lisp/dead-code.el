
;; my first elisp, it was so long ago
(defun cj-helper ()
  "shows what field our expression corresponds to"
  (interactive)
  (save-excursion
    (setq current-position (point))
    (beginning-of-line)
                                        ; count how many "${tab}"'s there are
    (let ((tab-count -1))  ; count
      (while (and (<= (point) current-position) (search-forward "${tab}" nil t))
        (incf tab-count)
        )
                                        ; now that we have the number of tabs, count number of |s
      (beginning-of-buffer)
      (search-forward "&PARAMETERS=")
      (message "after %d" (point))
      (let ((pipe-count 0))
        (while (< pipe-count tab-count)
          (search-forward "|")
          (message "at is %d" (point))
          (incf pipe-count)
          )
        (message "result %d %d %d" tab-count pipe-count (point))
        (let ((pipe-start (point)))
          (search-forward "|")
          (let ((pipe-end (point)))
            (message (concat "at " (buffer-substring pipe-start (- pipe-end 1))))
            )))
      )))
