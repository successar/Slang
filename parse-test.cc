#include "ast.h"
#include <stdio.h>
using namespace std;

FILE* fin;
extern Program root;
extern void yyparse();

int main(int argc, char** argv) {
	++argv; --argc;
	if( argc > 0 ) fin = fopen(argv[0], "r");
	else fin = stdin;
	yyparse();
	root->display();
}
