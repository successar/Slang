#pragma once
#include <vector>
#include <iostream>
#include <fstream>
#include <string.h>
#include "Var_table.cc"
using namespace std;

#define EXPR_VALS	\
	void display(int l);	\
	void cgen(ostream& os);	\
	void check();

class Program_class;
class Block_class;
class Expression_class;
class Formals_class;
class Function_class;
class Expressions_class;
class Struct_class;

typedef Program_class* Program;
typedef Block_class* Block;
typedef Expression_class* Expression;
typedef Formals_class* Formals;
typedef Function_class* Function;
typedef Expressions_class *VecExpr;
typedef Struct_class* Struct;

class Binary;
class Unary;
class Sizeof;
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

class Struct_Access;
class Struct_Assign;

#include "basic_classes.cc"
#include "exprs_classes.cc"

Program program();

Function function(Symbol name, Symbol ret_type, Formals args, Block blk);
Formals single_formal(Symbol name, Symbol type);
Formals append_formal(Formals f, Symbol name, Symbol type);

Struct structt(Symbol name, Formals args);

Block no_block();
Block single_block(Expression e1);
Block append_block(Block blk, Expression e1);

VecExpr no_exp();
VecExpr single_exp(Expression e1);
VecExpr append_exp(VecExpr v, Expression e1);

Expression call(Symbol name, VecExpr args);
Expression assign(Symbol var, Expression e1);

Expression binary(Expression e1, Expression e2, int op);
Expression unary(Expression e1, int op);
Expression size_of(Symbol type);

Expression let(Symbol var, Symbol type);
Expression cond(Expression cond, Block etrue, Block efalse);
Expression loop(Expression e1, Block cond);

Expression str_const(Symbol value);
Expression int_const(int var);
Expression object(Symbol var);

Expression array_let(Symbol var, Symbol given, int size);
Expression array_assign(Symbol var, Expression pos, Expression e1);
Expression array_access(Symbol var, Expression pos);

Expression struct_access(Expression e1, Symbol arg);
Expression struct_assign(Expression e1, Symbol arg, Expression e2);
