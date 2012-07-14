### Makefile --- 

include Makefile.rules

PROJ=<<<LOGIN>>>-<<<PROJECT>>>
BIN=<<<PROJECT>>>
FILES=src build

SRC=<<<MAIN>>>

VPATH=src:build
BUILD=$(SRC:.cc=.o)

$(BIN): $(BUILD)
	$(CXXC) $(LFLAGS) $(patsubst %, build/%,$(BUILD)) -o $(BIN)

%.o: %.cc
	$(CXXC) -c $(CFLAGS) $< -o build/$@

check:
	cd check && ./check

doc:

clean:
	rm -f $(BIN)
	rm -f build/*

dist: clean todo AUTHORS svn_check
	rm -rf $(PROJ)
	mkdir $(PROJ)
	cp -r Makefile AUTHORS TODO $(FILES) $(PROJ)
	-find $(PROJ) -name ".svn" -exec rm -rf {} \;
	-find $(PROJ) -name "*~" -exec rm -rf {} \;
	-find $(PROJ) -name "#*" -exec rm -rf {} \;
	tar cjvf $(PROJ).tar.bz2 $(PROJ)
	rm -rf $(PROJ)
	chmod 644 $(PROJ).tar.bz2

svn_check:
	@svn st | grep \? ; [ $$? = "1" ] \
	|| (echo "----------------------------------------------"\
	&& echo "SOME FILES ARE MISSING FROM THE SVN REPOSITORY"\
	&& echo "----------------------------------------------");

todo:
	grep "FIXME" -r . --exclude="Makefile" > TODO

.PHONY: doc check

### Makefile ends here
