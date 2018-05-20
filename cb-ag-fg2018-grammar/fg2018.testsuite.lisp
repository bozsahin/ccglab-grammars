;; numbers are indexes to the paper example numbers
;; load this file in CCGlab after you do (load-grammar "fg2018") 
;; then do (fg2018-ders) to see derivations of all examples,
;;   and (fg2018-lfs) just to see LFs.
;; -cem bozsahin may 2018
(defparameter *fg2018* '(
(2 (John persuaded Mary to hit the target))
(2a (John persuaded Mary hit the target))
(2b(John persuaded Mary to hits the target))
(3 (John persuaded Mary to hit Harry))
(12a (my team scored every which way))
(14 (John kicked and Mary did not kick the bucket))
(16 (I picked the book up))
(16p (I picked up the book))
(18 (the bucket that you kicked))
(19 (Mary dragged and John kicked the bucket))
(21a (At any rate you spilled the beans))
(21b (You spilled the beans at any rate))
(23 (You spilled and Mary cooked the beans))
(25 (You spilled and Mary cooked the beans))
(25v (You spilled and Mary spilled the beans))
(25alt (You spilled the beans))
(26 (the beans that you spilled))
(29 (I twiddled my thumbs))
(29p (I twiddled his thumbs))
(32c (persuade John to do the dishes easily))
))


(defun  fg2018-ders()
  (dolist (p *fg2018*)(progn (ccg-deduce (second p))
			   (format t "~%=======~%~s~%========~%" (first p))
			   (cky-show-deduction))))

(defun  fg2018-lfs()
  (dolist (p *fg2018*)
    (progn (ccg-deduce (second p))
	   (format t "~%=======~%~s~%========~%" (first p))
	   (cky-show-lf-eqv))))
