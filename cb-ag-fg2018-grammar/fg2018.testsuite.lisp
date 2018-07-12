;; numbers are indexes to the paper example numbers
;; load this file in CCGlab after you do (load-grammar "fg2018") 
;; then do (fg2018-ders) to see derivations of all examples,
;;   and (fg2018-lfs) just to see LFs.
;; -cem bozsahin may 2018
(defparameter *fg2018* '(
(2 (John persuaded Mary to hit the target) s)
(2a (John persuaded Mary hit the target) s)
(2b(John persuaded Mary to hits the target) s)
(3 (John persuaded Mary to hit Harry) s)
(12a (my team scored every which way) s)
(14 (John kicked and Mary did not kick the bucket) s)
(16 (I picked the book up) s)
(16p (I picked up the book) s)
(18 (the bucket that you kicked) nil)
(19 (Mary dragged and John kicked the bucket) s)
(21a (At any rate you spilled the beans) s)
(21b (You spilled the beans at any rate) s)
(23 (You spilled and Mary cooked the beans) s)
(25 (You spilled and Mary cooked the beans) s)
(25v (You spilled and Mary spilled the beans) s)
(25alt (You spilled the beans) s)
(26 (the beans that you spilled) nil)
(29 (I twiddled my thumbs) s)
(29p (I twiddled his thumbs) s)
(32c (persuade John to do the dishes easily) nil)
))


(defun  fg2018-ders()
  (dolist (p *fg2018*)(progn (ccg-deduce (second p))
			   (format t "~%=======~%~s~%========~%" (first p))
			   (cky-show-deduction (third p)))))

(defun  fg2018-lfs()
  (dolist (p *fg2018*)
    (progn (ccg-deduce (second p))
	   (format t "~%=======~%~s~%========~%" (first p))
	   (cky-show-lf-eqv))))
