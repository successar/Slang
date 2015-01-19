#include "ast.h"
#include "Var_table.cc"
#include <stdio.h>
using namespace std;

FILE* fin;
extern Program root;
extern void yyparse();
var_table vtbl;
str_table stbl;

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
	root_blk->check();
}

void Block_class::check() {
	for( int i = 0; i < exprs.size(); i++ ) {
		exprs[i]->check();
	}
}
