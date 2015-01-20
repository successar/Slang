#include "ast.h"
#include <stdio.h>
using namespace std;

FILE* fin;
extern Program root;
extern void yyparse();
str_table stbl;
var_table ftbl;
var_table* vtbl;

int main(int argc, char** argv) {
	++argv; --argc;
	if( argc > 0 ) fin = fopen(argv[0], "r");
	else fin = stdin;
	ofstream os("out.s");
	yyparse();
	root->display();
	root->semant();
	root->cgen(os);
}

void Program_class::semant(){
	for(int i = 0; i < funcs.size(); i++ ) {
		funcs[i]->check();
	}
}

void Block_class::check() {
	for( int i = 0; i < exprs.size(); i++ ) {
		exprs[i]->check();
	}
}
