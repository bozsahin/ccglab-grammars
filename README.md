# ccglab-grammars
sample grammars written in CCGlab, for linguistic analyses, modeling, training, etc.

<b>If you have a CCglab grammar developed, feel free to send a pull request.
We will put it up in this repo.</b>

In each folder:

  <code>.ccg</code> file is the source grammar you type. 

  <code>.ded</code> file is the lisp-ready code ccglab generates for linguistic analysis.

  <code>.ind</code> file is the lisp-ready code ccglab uses for training and parse ranking.

  <code>.sup</code> and <code>.supervision</code> files are for training from sentence-lf pairs.

Other files are auxiliary.

These grammars will be separated from ccglab source code soon for easier update.

-Cem Bozsahin
