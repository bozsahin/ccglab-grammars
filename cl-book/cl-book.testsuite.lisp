;; this is a test suite for cl-book.ccg grammar, for BTSO argument in Bozsahin 2012 CL book.
;; the inductive version shows the power of PCCG. Catalan number of LFs can be grouped
;; to collect the right statistics, and to return just one result.
;; This is not part of CCGlab package --hhcb
;; load this file in CCGlab after you did (load-grammar "cl-book") or 
;; (load-model "cl-book"), then run the relevant function defined below.

(defparameter *cl-book* '(
  (otest (i know what you can and what you should not do))
  (cl169 (the man who i think and who barry claims owns the house burns))
  (pargap (the book which i read without understanding burns))
  (joshihenderson (ken and barbie said that ken owns the house))
  (b3test (ver -dir -t))
  ))

(defun  cl-book-ders ()
  (dolist (p *cl-book*)(progn (ccg-deduce (second p))
			   (format t "~%=======~%~s~%========~%" (first p))
			   (cky-show-deduction))))

(defun  cl-book-probs()
  (dolist (p *cl-book*)(progn (ccg-induce (second p))
			   (format t "~%=======~%~s~%========~%" (first p))
			   (cky-show-induction)(status))))
(defun  cl-book-lfs ()
  (dolist (p *cl-book*)
    (progn (ccg-deduce (second p))
	   (format t "~%=======~%~s~%========~%" (first p))
	   (cky-show-lf-eqv))))
