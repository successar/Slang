#include "ast.h"
using namespace std;

////// ******* Binary Operation, Unary operation ********* ///////

class Binary : public Expression_class {
	Expression e1;
	Expression e2;
	int op;
	public :
	Binary(Expression exp1, Expression exp2, int arg_op) : e1(exp1), e2(exp2), op(arg_op) {};
	EXPR_VALS
};

class Unary : public Expression_class {
	Expression e1;
	int op;
	public :
	Unary(Expression arg_e1, int arg_op) : e1(arg_e1), op(arg_op) {};
	EXPR_VALS
};

/////// ******** Assign, Call *********** ///////

class Assign : public Expression_class {
	Symbol var;
	Expression e1;
	public :
	Assign(Symbol arg_var, Expression arg_e1) : var(arg_var), e1(arg_e1) {};
	EXPR_VALS
};

class Call : public Expression_class {
	Symbol name;
	VecExpr args;
	public :
	Call(Symbol arg_name, VecExpr arg_args) : name(arg_name), args(arg_args) {}
	EXPR_VALS
};

////// ****** Let, Loop, Condition ******* /////

class Let : public Expression_class {
	Symbol var;
	Symbol given_type;
	public :
	Let(Symbol arg_var, Symbol arg_type) : var(arg_var), given_type(arg_type) {};
	EXPR_VALS
};

class Cond : public Expression_class {
	Expression cond;
	Block etrue;
	Block efalse;
	public :
	Cond(Expression arg_cond, Block arg_etrue, Block arg_efalse) :
		cond(arg_cond), etrue(arg_etrue), efalse(arg_efalse) {};
	EXPR_VALS
};

class Loop : public Expression_class {
	Expression cond;
	Block e1;
	public :
	Loop(Expression arg_cond, Block arg_e1) : cond(arg_cond), e1(arg_e1) {}
	EXPR_VALS
};

// **** String constant, Integer Constant, Object ****** //

class Str_const : public Expression_class {
	Symbol value;
	public :
	Str_const(Symbol arg_value) : value(arg_value) {}
	EXPR_VALS
};

class Object : public Expression_class {
	Symbol var;
	public :
	Object(Symbol arg_var) : var(arg_var) {};
	EXPR_VALS
};

class Int_const : public Expression_class {
	int value;
	public :
	Int_const(int arg_value) : value(arg_value) {};
	EXPR_VALS
};

// ***** Array Operations ****** //

class Array_Let : public Expression_class {
    Symbol var;
    Symbol given_type;
    int size;
public :
    Array_Let(Symbol arg_var, Symbol agiven, int arg_size) : given_type(agiven), var(arg_var), size(arg_size) {}
    EXPR_VALS
};

class Array_Assign : public Expression_class {
    Symbol var;
    Expression pos;
    Expression e1;
public:
    Array_Assign(Symbol avar, Expression apos, Expression ae1) : var(avar), pos(apos), e1(ae1) {}
    EXPR_VALS
};

class Array_Access : public Expression_class {
    Symbol var;
    Expression pos;
public :
    Array_Access(Symbol avar, Expression apos) : var(avar), pos(apos) {}
    EXPR_VALS
};
