#include "ast.h"
using namespace std;

extern var_table vtbl;
extern str_table stbl;

void bin_op::check() {
	e1->check();
	e2->check();
}

void uni_op::check() {
	e1->check();
}


void Let::check() {
	e1->check();
	if( vtbl.lookup_var(var) != NULL) cout << "Let Error : Variable Redefined " << var->string() << endl;
	else vtbl.add_var(var);
}


void Assign::check() {
	e1->check();
	if (vtbl.lookup_var(var) == NULL) cout << "Assign Error : Variable Undefined " << var->string() << endl ;
}


void Cond::check() {
	cond->check();
	etrue->check();
	efalse->check();
}


void Object::check() {
	if (vtbl.lookup_var(var) == NULL) cout << "Object Error : Variable Undefined " << var->string() << endl ;
}

void Int_const::check() {}

void Print::check() {	e1->check();  }

void Read::check() {
	if (vtbl.lookup_var(var) == NULL) cout << "Object Error : Variable Undefined " << var->string() << endl ;
}

void Loop::check() {
	cond->check();
	e1->check();
}

void Str_const::check() {
	if( stbl.lookup_var(value) == NULL ) stbl.add_var(value);
}
