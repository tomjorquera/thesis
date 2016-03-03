An Adaptive Multi-Agent System for Self-Organizing Continuous Optimization
==========================================================================

This repository contains the source files of my PhD thesis in Artificial Intelligence, which I successfully defended in October 2013.

Description
-----------
The project is composed of the following folders:

* `generated` -- contains files automatically created by LaTeX (created by build script)
* `hooks` -- contains scripts executed by the VCS
* `libs` -- LaTeX library files used for the document
* `scripts` -- various scripts I created in an attempt to procrastinate on my thesis
* `sources` -- the source files of my thesis

Build
-----

The thesis is written in LaTeX, with bibliography in BibTeX, thus adequate compilers are required for both formats.
For convenience, a build.sh script is present at the project root. The script assumes both pdflatex and bibtex to be in your PATH.

To run the script:

	./build.sh manuscrit

This will create the `manuscrit.pdf` file in a `generated` folder at the root, along with some other intermediary files.

NOTE: the `sources` folder contains the file `these_couv_full.pdf` which corresponds to the cover used by my university. It is not used for the generation and (optionally) has to be appended at the beginning of the file manually.

License
-------

![CC-BY-SA](https://i.creativecommons.org/l/by-sa/4.0/88x31.png)

The full text of the thesis, along with all the images I produced, are licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-sa/4.0/). You can read a summary of the rights and restrictions of the license on [the creative commons official website](http://creativecommons.org/licenses/by-sa/4.0/).

The following image files are not my property and may be subject to a different license:
* `sources/StateoftheArt/figs/ConConvex_polygon_illustration1.png`, `sources/StateoftheArt/figs/ConConvex_polygon_illustration1.png` -- by [Oleg Alexandrov](http://commons.wikimedia.org/wiki/Category:Files_by_User:Oleg_Alexandrov_from_en.wikipedia)
* `sources/StateoftheArt/figs/Front-pareto.pdf` -- by [J. Dréo, CC-BY-SA](http://en.wikipedia.org/wiki/File:Front_pareto.svg)
* `sources/StateoftheArt/figs/Disciplines_Avion.png` -- source unknown, partially based on the work of C. W. Miller
* `sources/MAS4Optin/figs/Turbofan_operation.svg`, `sources/MAS4Optin/figs/Turbofan_operation.pdf` -- by [K. Aainsqatsi, CC-BY-SA](http://en.wikipedia.org/wiki/File:Turbofan_operation.svg)
* `sources/Implem/figs/AdelfePhases.png`, `sources/Implem/figs/amasmlAgent.png` -- by Sylvain Rougemaille, used with permission
