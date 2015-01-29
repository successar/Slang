#include "ast.h"
#include <stdio.h>
using namespace std;

FILE* fin;
extern Program root;
extern void yyparse();
str_table stbl;
var_table ftbl;
var_table* vtbl = NULL;
type_table ttbl;
struct_table ctbl;

int main(int argc, char** argv) {
    ++argv;
    --argc;

    ttbl.add_type("Str");
    ttbl.add_type("Int");

    Symbol print_int = new symtab_entry("print_int");
    ftbl.add_var(print_int, ttbl.lookup_type("Int"));

    Symbol print_str = new symtab_entry("print_str");
    ftbl.add_var(print_str, ttbl.lookup_type("Str"));

    Symbol read_str = new symtab_entry("read_str");
    ftbl.add_var(read_str, ttbl.lookup_type("Str"));

    Symbol read_int = new symtab_entry("read_int");
    ftbl.add_var(read_int, ttbl.lookup_type("Int"));

    if( argc > 0 ) fin = fopen(argv[0], "r");
    else fin = stdin;
    ofstream os("out.s");
    yyparse();
    root->semant();
    root->display();
    root->cgen(os);
}

void Program_class::semant() {
    for(int i = 0; i < structs.size(); i++ ) {
        ttbl.add_type(structs[i]->get_name()->string());
    }

    for(int i = 0; i < structs.size(); i++ ) {
        structs[i]->check();
    }

    for(int i = 0; i < funcs.size(); i++ ) {
        funcs[i]->check();
    }
}

void Block_class::check() {
    if( exprs.size() == 0 ) type = ttbl.lookup_type("Int");
    else {
        for( int i = 0; i < exprs.size(); i++ ) exprs[i]->check();
        type = exprs[exprs.size() - 1]->get_type();
    }
}
