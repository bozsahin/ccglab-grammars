;; load this file in CCGlab after you did (load-grammar "fragments")
;; then do (test-ders) to see the derivations.
;; (test-lfs) will verify the lambda reductions in case you are interested.
;; example numbers are from the paper; see fragments.ccg header.
;;  Interpreting the results of commented out examples needs another paper.
;; -cem bozsahin, May 2018
(defparameter *db* '(
  (4 (Can kediyi ve Ayşe köpeğe okşadı))
  (4p (Can kediyi ve Ayşe köpeği okşadı))
  (7 (Mary hits the target))
  (fig1a (Mary persuades John to hit the target))
  (fig1b (Mary promises John to hit the target))
  (fig1c (Mary expects John to hit the target))
;  (16a (the target which Mary knows that John believes that Harry spotted))
;  (16b (the books which I think that you have read without understanding))
;  (16c (the books which John believes and which Mary knows might skyrocket the
;	    sales))
  (21a (give Mary books and Klaus cds))
  (21b (Mary likes and John  hates cats))
  (22 (Mary persuades John to hit the target))
  (33a (dynes welodd gath))
  (33b (dynes welodd cath))
  (fig2a (arı sok -an kız))
  (fig2b ("arı sok" -an kız))
  (fig3 (kızı her arı soktu))
  (fig4a (soktu arı kızı))
  (fig4b (soktu kızı arı))
  (fig5 (bütün arılar soktu kızı))
  (44a (Eu não vi "os carros"))
  (44b (Eu não "os carros" vi))
  (44c (Eu não os vi))
  (44d (Eu os vi))
  (44ee1 (Eu não vi os))
  (43ee2 (Eu vi os))
  (fig5a ("O Paulo" não os viu))
  (fig6b (todos os viram))
  (fig6c (Eu não vi "os carros"))
  (48 ("A sopa" "O Paulo" comeu))
  ))

(defun  test-ders ()
  (status)
  (pprint (which-ccglab))
  (dolist (p *db*)(progn (ccg-deduce (second p))
			   (format t "~%=======~%~s~%========~%" (first p))
			   (cky-show-deduction (third p)))))

(defun  test-lfs ()
  (status)
  (pprint (which-ccglab))
  (dolist (p *db*)
    (progn (ccg-deduce (second p))
	   (format t "~%=======~%~s~%========~%" (first p))
	   (cky-show-lf-eqv))))
