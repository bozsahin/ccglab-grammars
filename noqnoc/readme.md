1. Created the text file g1.ccg. It is the grammar we wished to train.
2. Created the text file g1.supervision. It is the data we wish to train on.
3. In ccglab, did (load-grammar "g1" :maker 'sbcl). 
    It created the g1.ded file from g1.ccg. 
4. In ccglab, did (make-supervision "g1" :maker 'sbcl).
    It created the g1.sup file from g1.supervision.
5. Copied g1.ded to g1.ind to prepare for training.
6. Initialized the paremeters in cg1.ind. I kept them as 1.0.
7. In ccglab, did (update-model "g1" 10 1.0 1.0 :load t).
    It iterates over g1.sup 10 times, to update the parameters in g1.ind.
    1.0 and 1.0 are learning parameters alpha0 and c. NB. the manual.
8. In ccglab, did (save-training "new-g1.ind").
    It saves the trained grammar as new-g1.ind. 
9. In ccglab, do (load-model "new-g1") to start using the trained grammar.
10. One way is (rank '(john knows mary knows John))
    It will show the most likely LF for the example, among other things.
11. The '.out' file shows the details above in Lispese. It was started
    in ccglab as (dribble "g1.trained...out")
12. It's worth looking at, because it compares the untrained and trained grammar
        with some comments added on (by me) later.

enjoy.
-cem
