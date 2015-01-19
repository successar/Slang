#pragma once
#include <vector>
#include <iostream>
#include <fstream>
#include "Symbol.h"
#include "Var_table.cc"
using namespace std;

class Program_class;
class Block_class;
class Expression_class;
class Formals_class;
class Function_class;
class Expressions_class;

typedef Program_class* Program;
typedef Block_class* Block;
typedef Expression_class* Expression;
typedef Formals_class* Formals;
typedef Function_class* Function;
typedef Expressions_class *VecExpr;

class Expression_class {
	public:
	virtual void display(int l) {};	
	virtual void check() { }
	virtual void cgen(ostream &os);
	virtual int type() { return 'i'; }
};

class Block_class {
	vector<Expression> exprs;
	public :
	void append_expr(Expression expr) {
		exprs.push_back(expr);
	}
	void display(int l);
	void check();
	void cgen(ostream& os);
};

class Program_class {
	vector<Function> funcs;
	public : 
	void append_function(Function f) { funcs.push_back(f); }
	void display();
	void semant();
	void cgen(ofstream& os);
};

class bin_op : public Expression_class {
	Expression e1;
	Expression e2;
	int op;
	public :
	bin_op(Expression exp1, Expression exp2, int arg_op) : e1(exp1), e2(exp2), op(arg_op) {};
	void display(int l);
	void check();
	void cgen(ostream& os);
};

class Let : public Expression_class {
	Symbol var;
	Expression e1;
	public : 
	Let(Symbol arg_var, Expression arg_e1) : var(arg_var),e1(arg_e1) {};
	void display(int l);
	void check();
	void cgen(ostream& os);
};

class Cond : public Expression_class {
	Expression cond;
	Block etrue;
	Block efalse;
	public :
	Cond(Expression arg_cond, Block arg_etrue, Block arg_efalse) : 
		cond(arg_cond), etrue(arg_etrue), efalse(arg_efalse) {};
	void display(int l);
	void check();
	void cgen(ostream& os);
};

class Assign : public Expression_class {
	Symbol var;
	Expression e1;
	public :
	Assign(Symbol arg_var, Expression arg_e1) : var(arg_var), e1(arg_e1) {};
	void display(int l);
	void check();
	void cgen(ostream& os);
};

class uni_op : public Expression_class {
	Expression e1;
	int op;
	public : 
	uni_op(Expression arg_e1, int arg_op) : e1(arg_e1), op(arg_op) {};
	void display(int l);
	void check();
	void cgen(ostream& os);
};

class Object : public Expression_class {
	Symbol var;
	public :
	Object(Symbol arg_var) : var(arg_var) {};
	void display(int l);
	void check();
	void cgen(ostream& os);
};

class Int_const : public Expression_class {
	Symbol value;
	public :
	Int_const(Symbol arg_value) : value(arg_value) {};
	void display(int l);
	void check();
	void cgen(ostream& os);
};

class Print : public Expression_class {
	Expression e1;
	public :
	Print(Expression arg_e1) : e1(arg_e1) {}
	void display(int l);
	void check();
	void cgen(ostream& os);
};

class Read : public Expression_class {
	Symbol var;
	public :
	Read(Symbol arg_var) : var(arg_var) {}
	void display(int l);
	void check();
	void cgen(ostream& os);
};

class Loop : public Expression_class {
	Expression cond;
	Block e1;
	public :
	Loop(Expression arg_cond, Block arg_e1) : cond(arg_cond), e1(arg_e1) {}
	void display(int l);
	void check();
	void cgen(ostream& os);
}; 

class Str_const : public Expression_class {
	Symbol value;
	public :
	Str_const(Symbol arg_value) : value(arg_value) {}
	void display(int l);
	void check();
	void cgen(ostream& os);
	int type() { return 's'; }
};

class Formals_class {
	vector<Symbol> args;
	vector<Symbol> types;
	public :
	void append_formal(Symbol name, Symbol type) { args.push_back(name); types.push_back(type); }
	void display(int l);
};

class Function_class {
	Symbol name;
	Symbol ret_type;
	Formals args;
	Block blk;
	public :
	Function_class(Symbol arg_name, Symbol arg_ret_type, Formals arg_args, Block arg_blk) 
		: name(arg_name), ret_type(arg_ret_type), args(arg_args), blk(arg_blk) {}
	void display(int l);
};

class Expressions_class {
	vector<Expression> exprs;
	public: 
	void append_exp(Expression exp) { exprs.push_back(exp); }
	void display(int l);
};

class Call : public Expression_class {
	Symbol name;
	VecExpr args;
	public : 
	Call(Symbol arg_name, VecExpr arg_args) : name(arg_name), args(arg_args) {}
	void display(int l);
};

Program program();
Block no_block();
Block single_block(Expression e1);
Block append_block(Block blk, Expression e1);
VecExpr no_exp();
VecExpr single_exp(Expression e1);
VecExpr append_exp(VecExpr v, Expression e1);
Function function(Symbol name, Symbol ret_type, Formals args, Block blk);
Formals single_formal(Symbol name, Symbol type);
Formals append_formal(Formals f, Symbol name, Symbol type);

Expression call(Symbol name, VecExpr args);
Expression fbin_op(Expression e1, Expression e2, int op);
Expression funi_op(Expression e1, int op);
Expression assign(Symbol var, Expression e1);
Expression int_const(Symbol var);
Expression object(Symbol var);
Expression let(Symbol var, Expression e1);
Expression cond(Expression cond, Block etrue, Block efalse);
Expression print(Expression e1);
Expression read(Symbol var);
Expression loop(Expression e1, Block cond);
Expression str_const(Symbol value);
