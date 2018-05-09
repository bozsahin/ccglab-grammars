;; numbers are indexes to the paper example numbers
;; load this file in CCGlab after you do (load-grammar "fg2018") 
;; then do (fg2018-ders) to see derivations of all examples,
;;   and (fg2018-lfs) just to see LFs.
;; -cem bozsahin march 2018
(defparameter *fg2018* '(
(2 (John persuaded Mary to hit the target))
(2 (John persuaded Mary hit the target))
(2 (John persuaded Mary to hits the target))
(3 (John persuaded Mary to hit Harry))
(11a (my team scored every which way))
(13 (John kicked and Mary did not kick the bucket))
(15 (I picked the book up))
(15v (I picked up the book))
(17 (the bucket that you kicked))
(18 (Mary dragged and John kicked the bucket))
(21 (You spilled and Mary cooked the beans))
(23 (You spilled and Mary cooked the beans))
(23v (You spilled and Mary spilled the beans))
(23alt (You spilled the beans))
(24 (the beans that you spilled))
(27c (persuade John to do the dishes easily))
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
