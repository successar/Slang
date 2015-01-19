#include "ast.h"
#include "Var_table.cc"
#include "cgen.h"
using namespace std;

extern var_table vtbl;
extern str_table stbl;
int ifs = 0;
int whiles = 0;

void code_strings(ofstream& os) {
	for(int i = 0; i < stbl.size(); i++ ) {
		os << "str" << i << ":\t" << ".asciiz\t";
		os << "\"";
		for(int j = 0; j < stbl[i]->len(); j++ ) {
			char ch = (stbl[i]->string())[j];
			if( ch == '\n' ) os << "\\n";
			else os <<  ch;
		}
		os << "\"" << endl;
	}
}

void Program_class::cgen(ofstream& os) {
	os << "#Start of Code" << endl;	
	os << "\t.data" << endl;
	os << "str:\t" << ".asciiz \"\\n\"" << endl;
	code_strings(os);
	os << "\t" << ".text" << endl;
	os << "\t" << ".globl\tmain" << endl;
	os << "main:" << endl;
	os << MOVE << FP << ",\t" << SP << endl;
	os << ADDIU << SP << ",\t" << SP << ",\t" << -(vtbl.size() * WORD_SIZE) << endl; 
	root_blk->cgen(os);
	os << RET << endl;
	os << "#End of code" << endl;
}

void Block_class::cgen(ostream& os) {
	for(int i = 0; i < exprs.size(); i++ ) exprs[i]->cgen(os);
}

void Expression_class::cgen(ostream& os) {
	os << LI << V0 << ",\t" << 4 << endl;
	os << LA << ACC << ",\t" << "str" << endl;
	os << SYSCALL << endl;
}

void bin_op::cgen(ostream& os) {
	e1->cgen(os);
	push(ACC, os);
	e2->cgen(os);
	load(T1, 1, SP, os);
	pop(os);
	switch(op) {
		case '+' : os << ADD;break;
		case '-' : os << SUB;break;
		case '*' : os << MUL;break;
		case '/' : os << DIV;break;
		case '=' : os << SEQ;break;
		case '<' : os << SLT;break;
	}

	os << ACC << ",\t" << T1 << ",\t" << ACC << endl;
}

void uni_op::cgen(ostream& os) {
	e1->cgen(os);
	switch(op) {
		case '~' : os << NEG; break;
	}
	os << ACC << ",\t" << ACC << endl;
}

void Let::cgen(ostream& os) {
	int index = vtbl.lookup_index(var);
	e1->cgen(os);
	store(ACC, index, FP, os);	
}

void Assign::cgen(ostream& os) {
	int index = vtbl.lookup_index(var);
	e1->cgen(os);
	store(ACC, index, FP, os);
}

void Cond::cgen(ostream& os) {
	int ifbranch = ifs;
	ifs++;

	cond->cgen(os);
	os << BEQZ << ACC << ",\tfalse" << ifbranch << endl;
	os << "true" << ifbranch << ":" << endl;
	etrue->cgen(os);
	os << BRANCH << "endif" << ifbranch << endl;
	os << "false" << ifbranch << ":" << endl;
	efalse->cgen(os);
	os << "endif" << ifbranch << ":" << endl;	
}

void Int_const::cgen(ostream& os) {
	char* str = value->string();
	os << LI << ACC << ",\t" << str << endl;
}
void Object::cgen(ostream& os) {
	int index = vtbl.lookup_index(var);
	load(ACC, index, FP, os);
}

void Print::cgen(ostream& os) {
	e1->cgen(os);
	push(ACC, os);
	if( e1->type() == 'i') os << LI << V0 << ",\t" << 1 << endl;
	else os << LI << V0 << ",\t" << 4 << endl;
	os << SYSCALL << endl;
	load(ACC, 1, SP, os);
	pop(os);
}

void Read::cgen(ostream& os) {
	os << LI << V0 << ",\t" << 5 << endl;
	os << SYSCALL << endl;
	int index = vtbl.lookup_index(var);
	store(V0, index, FP, os);
	os << MOVE << ACC  << ",\t" << V0 << endl;
}

void Loop::cgen(ostream& os) {
	int w = whiles;
	whiles++;
	
	os << "while" << w << ":" << endl;
	cond->cgen(os);
	os << BEQZ << ACC << ",\tloop" << w << endl;
	e1->cgen(os);
	os << BRANCH << "while" << w << endl;
	os << "loop" << w << ":" << endl;		
}

void Str_const::cgen(ostream& os) {
	int index = stbl.lookup_index(value);
	os << LA << ACC << ",\tstr" << index << endl;
} 
