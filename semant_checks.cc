#include "ast.h"
using namespace std;

extern var_table* vtbl;
extern str_table stbl;
extern var_table ftbl;
extern type_table ttbl;

int check_type(Symbol type) {
	if( strcasecmp(type->string(), "Int") == 0 ) return 1;
	if( strcasecmp(type->string(), "Str") == 0 ) return 1;
	return 0;
}

void Binary::check() {
	e1->check();
	e2->check();
	if ( e1->get_type() != e2->get_type() ) cout << "Type Mismatch : Binary Expression" << endl;
	type = e1->get_type();
}

void Unary::check() {
	e1->check();
	type = e1->get_type();
}

void Loop::check() {
	cond->check();
	e1->check();
	type = e1->get_type();
}

void Str_const::check() {
	type = ttbl.lookup_type("Str");
	if( stbl.lookup_var(value) == NULL ) stbl.add_var(value, type);
}

void Int_const::check() {
	type = ttbl.lookup_type("Int");
}

void Cond::check() {
	cond->check();
	etrue->check();
	efalse->check();
	if( etrue->get_type() != efalse->get_type() ) cout << "Type Mismatch : Condition" << endl;
	type = etrue->get_type();
}

void Let::check() {
	e1->check();
	type = e1->get_type();

	if( given_type != type ) cout << "Type Mismatch : Let" << endl;
	given_type = e1->get_type();

	if( vtbl->lookup_var(var) != NULL) cout << "Let Error : Variable Redefined " << var->string() << endl;
	else vtbl->add_var(var, type);

}
void Assign::check() {

	e1->check();
	type = e1->get_type();

	if (vtbl->lookup_var(var) == NULL) cout << "Assign Error : Variable Undefined " << var->string() << endl ;
	else type = vtbl->lookup_type(var);

}

void Object::check() {

	type = ttbl.lookup_type("Int");
	if (vtbl->lookup_var(var) == NULL) cout << "Object Error : Variable Undefined " << var->string() << endl ;
	else type = vtbl->lookup_type(var);

}

void Formals_class::check() {
	for(int i = 0; i < args.size(); i++) {
		if( check_type(types[i]) == 0 ) cout << "Type Not Present in Formal : " << args[i]->string() << endl;
		else vtbl->add_var(args[i], types[i]);
	}
}

void Function_class::check() {
	vtbl = &vars;
	ftbl.add_var(name, ret_type);
	if( check_type(ret_type) == 0 ) cout << "Type Not Present in Return Type for " << name->string() << endl;
	args->check();
	blk->check();
	if ( ret_type != blk->get_type() ) cout << "Type Mismatch in Function : " << name->string() << endl;
}

void Expressions_class::check() {
	for(int i = 0; i < exprs.size(); i++ ) exprs[i]->check();
}

void Call::check() {
	type = ttbl.lookup_type("Int");
	if( ftbl.lookup_var(name) == NULL ) cout << "Function not present " << name->string() << endl;
	else type = ftbl.lookup_type(name);
	args->check();
}

void Array_Let::check() {
    type = given_type;
    if( vtbl->lookup_var(var) != NULL ) cout << "Variable Redefined  : " << var->string() << endl;
    else vtbl->add_var(var, given_type, size);
}

void Array_Assign::check() {
    type = ttbl.lookup_type("Int");
    e1->check();
    pos->check();
    if( vtbl->lookup_var(var) == NULL ) cout << "Variable Undefined  : " << var->string() << endl;
    else type = vtbl->lookup_type(var);

    if( pos->get_type() != ttbl.lookup_type("Int")) cout << "Position not integer : " << var->string() << endl;
    if( e1->get_type() != type ) cout << "Type Mismatch in Array Assign : " << var->string() << endl;
}

void Array_Access::check() {
    type = ttbl.lookup_type("Int");
    pos->check();
    if( vtbl->lookup_var(var) == NULL ) cout << "Variable Undefined  : " << var->string() << endl;
    else type = vtbl->lookup_type(var);
}
