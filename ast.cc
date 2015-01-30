#include "ast.h"
#include "stdio.h"
using namespace std;

Program program() { return new Program_class(); }

Block no_block() { return new Block_class(); }
Block append_block(Block blk, Expression e1) { blk->append_expr(e1); return blk; }
Block single_block(Expression e1) {
	Block blk = new Block_class();
	blk->append_expr(e1);
	return blk;
};

Expression binary(Expression e1, Expression e2, int op) { Binary* expr = new Binary(e1, e2, op); return expr; }
Expression unary(Expression e1, int op) { Unary* expr = new Unary(e1, op); return expr; }
Expression size_of(Symbol type) { return new Sizeof(type); }

Expression assign(Symbol var, Expression e1) { Assign* expr = new Assign(var, e1); return expr; }
Expression call(Symbol name, VecExpr args) { Call* c = new Call(name, args); return c; }

Expression let(Symbol var, Symbol type) { Let* expr = new Let(var, type); return expr; }
Expression cond(Expression cond, Block etrue, Block efalse) { Cond* ifcond = new Cond(cond, etrue, efalse); return ifcond; }
Expression loop(Expression cond, Block e1) { Loop* expr = new Loop(cond, e1); return expr; }

Expression str_const(Symbol value) { Str_const* str = new Str_const(value); return str; }
Expression int_const(int var) { Int_const* iconst = new Int_const(var); return iconst; }
Expression object(Symbol var) { Object* obj = new Object(var); return obj; }

Expression array_let(Symbol var, Symbol given, int size) { return new Array_Let(var, given, size); }
Expression array_assign(Symbol var, Expression pos, Expression e1) { return new Array_Assign(var, pos, e1); }
Expression array_access(Symbol var, Expression pos){ return new Array_Access(var, pos); }

Expression struct_access(Expression e1, Symbol arg) { return new Struct_Access(e1, arg); }
Expression struct_assign(Expression e1, Symbol arg, Expression e2) { return new Struct_Assign(e1, arg, e2); }

Function function(Symbol name, Symbol ret_type, Formals args, Block blk) {
	return new Function_class(name, ret_type, args, blk);
}
Struct structt(Symbol name, Formals args) { return new Struct_class(name, args); }

Formals single_formal(Symbol name, Symbol type) {
	Formals f = new Formals_class();
	f->append_formal(name, type);
	return f;
}
Formals append_formal(Formals f, Symbol name, Symbol type) { f->append_formal(name, type); return f; }

VecExpr no_exp() { return new Expressions_class(); }
VecExpr single_exp(Expression e1) { VecExpr v = new Expressions_class(); v->append_exp(e1); return v; }
VecExpr append_exp(VecExpr v, Expression e1) { v->append_exp(e1); return v; }

