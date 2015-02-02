SRC = parser-tab.cc lexer-tab.cc display_ast.cc ast.cc \
	Var_table.cc semant.cc semant_checks.cc cgen.cc
INCL = ast.h Symbol.h parser-header.h cgen.h
OBJS = ${SRC:.cc=.o}

parser : ${OBJS}
	g++ -lm -o slang ${OBJS}

.cc.o : ${INCL}
	g++ -c -Wno-write-strings -g3 $<

parser-tab.cc : parser.y
	bison -d parser.y
	mv -f parser.tab.c parser-tab.cc
	mv -f parser.tab.h parser-header.h

lexer-tab.cc : lang.flex parser-header.h
	flex lang.flex
	mv -f lex.yy.c lexer-tab.cc

clean :
	rm slang ${OBJS} parser-tab.cc parser-header.h lexer-tab.cc *~
