#include "ast.h"
#include <iostream>
using namespace std;

void Program_class::display() { root_blk->display(0); }

void Block_class::display(int l) {
	for(int i = 0; i < exprs.size(); i++ ) { exprs[i]->display(l); }
	cout << endl; 
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
