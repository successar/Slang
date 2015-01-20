#include "ast.h"
using namespace std;

extern var_table* vtbl;
extern str_table stbl;
extern var_table ftbl;

int check_type(Symbol type);

void bin_op::check() {	e1->check();	e2->check(); }
void uni_op::check() {	e1->check(); }
void Loop::check() {	cond->check();	e1->check(); }
void Str_const::check() { if( stbl.lookup_var(value) == NULL ) stbl.add_var(value); }
void Cond::check() {	cond->check();	etrue->check();	efalse->check(); }
void Int_const::check() {}
void Print::check() {	e1->check();  }
void Let::check() {
	e1->check();
	if( vtbl->lookup_var(var) != NULL) cout << "Let Error : Variable Redefined " << var->string() << endl;
	else vtbl->add_var(var);
}
void Assign::check() {
	e1->check();
	if (vtbl->lookup_var(var) == NULL) cout << "Assign Error : Variable Undefined " << var->string() << endl ;
}

void Object::check() {
	if (vtbl->lookup_var(var) == NULL) cout << "Object Error : Variable Undefined " << var->string() << endl ;
}
void Read::check() {
	if (vtbl->lookup_var(var) == NULL) cout << "Object Error : Variable Undefined " << var->string() << endl ;
}
void Formals_class::check() {
	for(int i = 0; i < args.size(); i++) {
		if( check_type(types[i]) == 0 ) cout << "Type Not Present in Formal : " << args[i]->string() << endl;
		else vtbl->add_var(args[i]);
	}
}
void Function_class::check() {
	vtbl = &vars;
	ftbl.add_var(name);
	if( check_type(ret_type) == 0 ) cout << "Type Not Present in Return Type for " << name->string() << endl;
	args->check();
	blk->check();
}

void Expressions_class::check() { for(int i = 0; i < exprs.size(); i++ ) exprs[i]->check(); }
void Call::check() {
	if( ftbl.lookup_var(name) == NULL ) cout << "Function not present " << name->string() << endl;
	args->check();
}

int check_type(Symbol type) {
	if( strcmp(type->string() , "INT") == 0 ) return 'i';
	if( strcmp(type->string() , "STR") == 0 ) return 's';
	return 0;
}		


