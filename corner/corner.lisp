;;;; model-specific code for corner project - Cem Bozsahin, 2016, Lisboa

;; ADT for conceptual structure and its potential realization
(defmacro get-con (concept)
  `(first ,concept))
(defmacro get-con-args (concept)
  `(second ,concept))
(defmacro get-con-funcs (concept)
  `(third ,concept))

(defparameter *concepts*    ;; p: participant l: location a: act r: property (last arg is least oblique to concept)
                            ;; these are considered natural kinds (Fodor style)
			    ;; ADT 1st: concept 2nd: args as natural kinds 3rd: template functions
 '((!sleep (p)(iv))
   (!hit (p p) (tv tv-ana tv-wrap-pro tv-wrap-ana tv-pro))
   (!work (l p) (tv tv-ana tv-wrap-pro tv-wrap-ana tv-pro))
   (!try (a p) (tv tv-ana tv-wrap-pro tv-wrap-ana tv-pro cont1))
   (!go (l p)(tv tv-ana tv-wrap-pro tv-wrap-ana tv-pro))
   (!claim (a p)(tv tv-ana tv-wrap-pro tv-wrap-ana tv-pro))
   (!see (p p)(tv tv-ana tv-wrap-pro tv-wrap-ana tv-pro))
   (!pred (a a)(tv tv-ana tv-wrap-pro tv-wrap-ana tv-pro))
   (!pred2 (a a d)(dv))
   (!see2 (a p)(tv tv-ana tv-wrap-pro tv-wrap-ana tv-pro cont1))
   (!think (a p)(tv tv-ana tv-wrap-pro tv-wrap-ana tv-pro))
   (!be (r p)(tv tv-ana tv-wrap-pro tv-wrap-ana tv-pro))
   ))

(defparameter *consyns* ; list of syn types per concept type
  '((p np)
    (d np pp ap)
    (a s vp)
    (l pp np)
    (r n)))

(defvar *gencats*) ; list of generated patterns for all concepts
(defvar *verbcats*) ; list of generated syn-lf pairs for all concepts, from patterns
(defvar *concept-subcat-table*)  ; compiled table of *concepts* x *consyns*
   
(defun permute (lst &optional (remain lst))
  (cond ((null remain) nil)
	((null (rest lst)) (list lst))
	(t (append
	     (mapcar (lambda (l) (cons (first lst) l))
		     (permute (rest lst)))
	     (permute (append (rest lst) (list (first lst))) (rest remain))))))

;; Functions that generate verbal templates depending on arity.
;; these are not macros but functions because they are called by apply of Lisp

(defun fixed-parts (k f)
  "Features other than syn-sem. 'Remark' is the name of the function that generates the template."
  `((KEY ,k)(PHON p)(MORPH V)(PARAM 1.0)(REMARK ,f)))

(defun iv (concept arg dir)
  `((SYN (((BCAT S) (FEATS NIL)) 
	  (DIR ,dir) (MODAL ALL) 
	  ((BCAT ,arg) (FEATS NIL))))
    (SEM (LAM X (,concept X)))))

(defun tv (concept arg1 dir1 arg2 dir2)
  `((SYN ((((BCAT S) (FEATS NIL)) (DIR ,dir1) (MODAL ALL) 
				     ((BCAT ,arg1) (FEATS NIL)))
	  (DIR ,dir2) (MODAL ALL) ((BCAT ,arg2) (FEATS ((TYP FULL))))))
    (SEM (LAM X (LAM Y ((,concept X) Y))))))

(defun tv-wrap (concept arg1 dir1 arg2 dir2)   ; as a consequence of PFTL 
  `((SYN ((((BCAT S) (FEATS NIL)) (DIR ,dir1) (MODAL ALL) 
				     ((BCAT ,arg1) (FEATS ((TYP FULL)))))
	  (DIR ,dir2) (MODAL ALL) ((BCAT ,arg2) (FEATS NIL))))
    (SEM (LAM Y (LAM X ((,concept X) Y))))))

(defun tv-wrap-pro (concept arg1 dir1 arg2 dir2)   ; as a consequence of PFTL binding theory
  `((SYN ((((BCAT S) (FEATS NIL)) (DIR ,dir1) (MODAL ALL) 
				     ((BCAT ,arg1) (FEATS ((TYP PRO)))))
	  (DIR ,dir2) (MODAL ALL) ((BCAT ,arg2) (FEATS NIL))))
    (SEM (LAM Y (LAM X ((,concept ("SK" X)) Y))))))

(defun tv-wrap-ana (concept arg1 dir1 arg2 dir2)   ; as a consequence of PFTL binding theory
  `((SYN ((((BCAT S) (FEATS NIL)) (DIR ,dir1) (MODAL ALL) 
				     ((BCAT ,arg1) (FEATS ((TYP ANA)))))
	  (DIR ,dir2) (MODAL ALL) ((BCAT ,arg2) (FEATS NIL))))
    (SEM (LAM Y (LAM X ((,concept (("SK" X) Y)) Y))))))

(defun tv-pro (concept arg1 dir1 arg2 dir2)   ; as a consequence of binding theory in PFTL
  `((SYN ((((BCAT S) (FEATS NIL)) (DIR ,dir1) (MODAL ALL) 
				     ((BCAT ,arg1) (FEATS NIL)))
	  (DIR ,dir2) (MODAL ALL) ((BCAT ,arg2) (FEATS ((TYP PRO))))))
    (SEM (LAM X (LAM Y ((,concept ("SK" X)) Y))))))

(defun tv-ana (concept arg1 dir1 arg2 dir2)   ; as a consequence of binding theory in PFTL
  `((SYN ((((BCAT S) (FEATS NIL)) (DIR ,dir1) (MODAL ALL) 
				     ((BCAT ,arg1) (FEATS NIL)))
	  (DIR ,dir2) (MODAL ALL) ((BCAT ,arg2) (FEATS ((TYP ANA))))))
    (SEM (LAM X (LAM Y ((,concept (("SK" X) Y)) Y))))))

(defun dv (concept arg1 dir1 arg2 dir2 arg3 dir3)
  `((SYN (((((BCAT S) (FEATS NIL)) (DIR ,dir1) (MODAL ALL) 
				      ((BCAT ,arg1) (FEATS NIL)))
	   (DIR ,dir2) (MODAL ALL) ((BCAT ,arg2) (FEATS ((TYP FULL)))))
	  (DIR ,dir3) (MODAL ALL) ((BCAT ,arg3) (FEATS ((TYP FULL))))))
    (SEM (LAM X (LAM Y (LAM Z (((,concept X) Y) Z)))))))

(defun cont1 (concept arg1 dir1 arg2 dir2)
  `((SYN ((((BCAT S) (FEATS NIL)) (DIR ,dir1) (MODAL ALL) 
				     ((BCAT,arg1) (FEATS NIL)))
	  (DIR ,dir2) (MODAL ALL) ((BCAT ,arg2) (FEATS NIL))))
    (SEM (LAM P (LAM X ((,concept (("SK" X) "CTRL")) X))))))

(defun compile-subcats ()
  "creates the concept-subcat-table from concept x consyn"
  (setf *concept-subcat-table* nil)
  (dolist (concept *concepts*)
    (let* ((con (get-con concept))
	   (args (get-con-args concept))
	   (conlist (list con)))
      (dolist (arg args)
	(push (rest (assoc arg *consyns*)) conlist))
      (setf conlist (reverse conlist))
      (push conlist *concept-subcat-table*))))

(defun add-at-end (sls lols)
  "adds sublists in sls to end of each list in lols, assuming it is a list of lists"
  (let ((l nil))
    (dolist (sl sls)
      (dolist (lol lols)
	(push (append lol sl) l)))
    l))
	
(defun gen-verb1 (subcats &optional (gencats nil))
  "populate gencats from concepts and consyns via concept-subcat-table"
  (cond ((null subcats) gencats)
	(t (let ((rl nil))
	     (dolist (r (first subcats))
	       (push (list r 'BS) rl)
	       (push (list r 'FS) rl))
	     (cond ((null gencats) (gen-verb1 (rest subcats) rl))
		   (t (gen-verb1 (rest subcats) (add-at-end rl gencats))))))))

(defun gen-verb2 (&optional (key -1))
  "populate verbcats from gencat.
  Use negative keys by default, to distinguish them from manually created lex items"
  (setf *verbcats* nil)
  (dolist (gencat *gencats*)
    (let* ((concept (first gencat))
	   (realizations (rest gencat))
	   (functions (get-con-funcs (assoc concept *concepts*))))
      (dolist (f functions)
	(dolist (r realizations)
	  (push (append (fixed-parts key f) 
			(apply (coerce f 'function) (cons concept r)))
		*verbcats*)
	  (decf key))))))

(defun gen-verbs ()
  "from concept subcat lists generate all templatic categories for the concept."
  (setf *gencats* nil)
  (compile-subcats)
  (dolist (con *concept-subcat-table*)
    (push (cons (first con) (gen-verb1 (rest con))) *gencats*))
  (gen-verb2))

(defun save-verbs (fn)
  (with-open-file (s fn  :direction :output :if-exists :supersede)
    (prin1 *verbcats* s))
  t)
