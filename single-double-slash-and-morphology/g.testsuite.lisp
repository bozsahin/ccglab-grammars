(defparameter *data* '(
(1 (adam -in oku -dugu kitap))
(2 (adam -in oku -yan kitap))
(3 (kitap -i oku -yan adam))
(4 (kitap -i oku -dugu adam))
))

(defun  ders-test() ;; derivations test--going through all of them
  (dolist (p *data*)(progn (ccg-deduce (second p))
			   (format t "~%=======~%~s~%========~%" (first p))
			   (cky-show-deduction))))

(defun  lf-test() ;; verifying lfs for well formedness --- adequacy is up to you
  (dolist (p *data*)
    (progn (ccg-deduce (second p))
	   (format t "~%=======~%~s~%========~%" (first p))
	   (cky-show-lf-eqv))))
