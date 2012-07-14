### Makefile --- 

## Author: jardonnet@lrde.epita.fr
## Version: $Id: Makefile,v 0.0 2008/06/08 11:19:55 ugo Exp $
## Keywords: 
## X-URL: 

PROJ=calc
SOURCE= src/math_ev.ml		\
	src/math_fct.ml		\
	src/math_lazy.ml	\
	src/math.ml		\
	src/math_parseur.ml
BIN=calc
FILES=src

all:
	

check:
	

doc:
	

clean:
	rm -rf $(BIN) *.cmi *.cmo

dist:	clean todo AUTHORS svn_check
	chmod -R 744 .
	chmod 755 `find . -type d`
	rm -rf $(PROJ)
	mkdir $(PROJ)
	cp -r Makefile $(FILES) $(PROJ)
	-find $(PROJ) -name ".svn" -exec rm -rf {} \;
	-find $(PROJ) -name "*~" -exec rm -rf {} \;
	-find $(PROJ) -name "#*" -exec rm -rf {} \;
	tar cjpvf $(PROJ).tar.bz2 $(PROJ)
	rm -rf $(PROJ)
	chmod 644 $(PROJ).tar.bz2

svn_check:
	@svn st | grep \? ; [ $$? = "1" ] \
	|| (echo "----------------------------------------------"\
	&& echo "SOME FILES ARE MISSING FROM THE SVN REPOSITORY"\
	&& echo "----------------------------------------------");

todo:
	grep "FIXME" -r src/ --include='*.d'> TODO || \
	echo "NOTHING" > TODO

.PHONY: doc check

### Makefile ends here