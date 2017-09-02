;; this file explains how the throught experiment was conducted step by step
;; run it after you are logged on to ccglab-- it's all Lisp code
;; -cem bozsahin

(defun test-noqnoc ()
  (progn
    (lg "g1" :maker 'sbcl)  ; creates and loads the .ded file from .ccg
    (sg "g1.ind")           ; saves currently loaded grammar as .ind
    (um "g1" 10 1.0 1.0 :load t)  ; updates g1.ind after loading it, usiing g1.sup
    (st)			; shows training
    ))
