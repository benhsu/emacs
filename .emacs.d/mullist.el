
;;#00ff00
;;#000000

(defun mullist (x y)
  (cond ((null y)  '())
        ((null (cdr x)) (append (list (concat (car x) (car y))) (mullist x (cdr y))))
        (t (append (mullist (list (car x)) y) (mullist (cdr x) y)))))
  ;; (list (concat (car x) (car y))
  ;;       (mullist x (cdr y))))

(message (mullist '("a" "b" "c") '("a" "s" "d")))
