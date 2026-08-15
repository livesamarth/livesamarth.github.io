TEX = resume.tex
PDF = resume.pdf

.PHONY: build open clean rebuild

build:
	latexmk $(TEX)

open: build
	open $(PDF)

clean:
	latexmk -C

rebuild: clean build