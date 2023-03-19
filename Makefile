TEX:=$(wildcard *.tex)
TEX_PDF=$(TEX:.tex=.pdf)
AUX=$(TEX:.tex=.aux)
LOGOS:=$(wildcard logos/*.svg)
FIGURAS:=$(wildcard img/*.svg)
FIGURAS_NPDF:=$(wildcard img/*.png img/*.jpg)
CODIGO=
BIB=refimg.bib
LOGOS_PDF=$(LOGOS:.svg=.pdf)
FIGURAS_PDF=$(FIGURAS:.svg=.pdf)
CODIGO_PDF=$(CODIGO:.c=.pdf)
PDF=$(FIGURAS_PDF) $(CODIGO_PDF) $(LOGOS_PDF)
NPDF=$(FIGURAS_NPDF)
GARBAGE=*.aux *.bbl *.blg *.log *.toc *.lof *.nav *.out *.snm

all: $(TEX_PDF)

$(TEX_PDF): %.pdf : %.tex $(PDF) $(NPDF) $(BIB)
	rm -f *.lof
	pdflatex -interaction=nonstopmode -halt-on-error $<
	bibtex $(<:.tex=.aux) || true
	pdflatex -interaction=nonstopmode -halt-on-error $<
	pdflatex -interaction=nonstopmode -halt-on-error $<

$(FIGURAS_PDF): %.pdf : %.svg
	DISPLAY="" inkscape $^ --batch-process --export-area-page -o $@

$(LOGOS_PDF): %.pdf : %.svg
	DISPLAY="" inkscape $^ --batch-process --export-area-drawing -o $@

$(CODIGO_PDF): %.pdf :%.c
	echo ":set syntax \n\
	:set number \n\
	:set printfont=currier:8 \n\
	:set printoptions=number:y,header:0 \n\
	:colorscheme default \n\
	:hardcopy > "$(<:.cpp=.ps) "\n:q\n" | vim $<
	echo "file-open:$(<:.cpp=.ps);\
		export-area-drawing;\
		export-filename:$@;\
		export-do"\
		| inkscape --shell
	rm $(<:.cpp=.ps)

clean:
	rm -f $(GARBAGE)
	rm -f $(PDF) $(DATOS) $(TEX_PDF)

clean-garbage:
	rm -f $(GARBAGE)

pdf-only: all clean-garbage
	rm -f $(PDF)

help:
	@echo make all
	@echo - Creates all files
	@echo make pdf-only
	@echo - Removes temporary files
	@echo make resize
	@echo - Resize all raster graphics to 1080px width
	@echo make clean
	@echo - Removes all files
	@echo make help
	@echo - Shows this help

resize:
	mogrify -verbose -resize "1080x>" $(NPDF)
