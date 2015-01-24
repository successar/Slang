#pragma once
#include <vector>
#include <iostream>
#include <fstream>
#include <string.h>
#include "Var_table.cc"
#include "ast_exp_defs.cc"
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
	Symbol type;
	Symbol get_type() { return type; };
};

class Block_class {
	vector<Expression> exprs;
	public :
	void append_expr(Expression expr) {
		exprs.push_back(expr);
	}
	EXPR_VALS
	Symbol type;
	Symbol get_type() { return type; }
};

class Program_class {
	vector<Function> funcs;
	public :
	void append_function(Function f) { funcs.push_back(f); }
	void display();
	void semant();
	void cgen(ofstream& os);
};


class Formals_class {
	vector<Symbol> args;
	vector<Symbol> types;
	public :
	void append_formal(Symbol name, Symbol type) { args.push_back(name); types.push_back(type); }
	int size() { return args.size(); }
	EXPR_VALS
};

class Function_class {
	Symbol name;
	Symbol ret_type;
	Formals args;
	Block blk;
	var_table vars;
	public :
	Function_class(Symbol arg_name, Symbol arg_ret_type, Formals arg_args, Block arg_blk)
		: name(arg_name), ret_type(arg_ret_type), args(arg_args), blk(arg_blk) {}
	EXPR_VALS
};

class Expressions_class {
	vector<Expression> exprs;
	public:
	void append_exp(Expression exp) { exprs.push_back(exp); }
	int size() { return exprs.size(); }
	EXPR_VALS
};

class Binary;
class Unary;
class Assign;
class Call;
class Let;
class Cond;
class Loop;
class Int_const;
class Str_const;
class Object;

class Array_Access;
class Array_Let;
class Array_Assign;

#include "exprs_classes.cc"

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
Expression assign(Symbol var, Expression e1);

Expression binary(Expression e1, Expression e2, int op);
Expression unary(Expression e1, int op);

Expression let(Symbol var, Symbol type, Expression e1);
Expression cond(Expression cond, Block etrue, Block efalse);
Expression loop(Expression e1, Block cond);

Expression str_const(Symbol value);
Expression int_const(int var);
Expression object(Symbol var);

Expression array_let(Symbol var, Symbol given, int size);
Expression array_assign(Symbol var, Expression pos, Expression e1);
Expression array_access(Symbol var, Expression pos);
