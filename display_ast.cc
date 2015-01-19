#include "ast.h"
#include <iostream>
using namespace std;

void Program_class::display() { 
	for(int i = 0; i < funcs.size(); i++ ) funcs[i]->display(0); 
}

void Block_class::display(int l) {
	for(int i = 0; i < exprs.size(); i++ ) { exprs[i]->display(l); }
	cout << endl; 
}

void Function_class::display(int l) {
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "Function : " << ret_type->string() << " " << name->string() << " (";
	args->display(l); cout << ")" << endl;
	blk->display(l + 1); 
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "End Function " << name->string() << endl << endl;

}

void Formals_class::display(int l) {
	if(args.size() > 0) {	
	cout << types[0]->string() << " " << args[0]->string() ;
	for(int i = 1; i < args.size(); i++ ) cout << ", " << types[i]->string() << " " << args[i]->string();
	}
}

void bin_op::display(int l) {
	e1->display(l + 1);
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "Binary op : " << (char) op << endl;
	e2->display(l + 1);
}

void uni_op::display(int l) {
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "Unary op : " << (char) op << endl;
	e1->display(l + 1);
}

void Call::display(int l) {
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "Function Call : " << name->string() << " Arguments : " << endl;
	args->display(l + 1);
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "End Function Call" << endl;
}

void Let::display(int l) {
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "LET : " << var->string() << endl;
	e1->display(l + 1);
}

void Cond::display(int l) {
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "Condition : " << endl;
	cond->display(l+1);
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "True Branch : " << endl;
	etrue->display(l+1);
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "False Branch : " << endl;
	efalse->display(l+1);
}

void Assign::display(int l) {
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "Assign : " << var->string() << endl;
	e1->display(l + 1);
}	

void Int_const::display(int l) {
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "Integer : " << value->string() << endl;
}

void Object::display(int l) {
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "Variable : " << var->string() << endl;
}

void Print::display(int l) {
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "Print : " << endl;
	e1->display(l + 1);
}

void Read::display(int l) {
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "Read : " << var->string() << endl;
}

void Loop::display(int l) {
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "While Condition : " << endl;
	cond->display(l);
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "Begin : " << endl;
	e1->display(l);
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "Loop" << endl;
}

void Str_const::display(int l) {
	for(int i = 0; i < l; i++) cout << '\t';
	cout << "String : " << value->string() << endl;
}

void Expressions_class::display(int l) {
	for(int i = 0; i < exprs.size(); i++ ) exprs[i]->display(l);
}
