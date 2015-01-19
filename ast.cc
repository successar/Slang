#include "ast.h"
#include "stdio.h"
using namespace std;

Program program(Block blk) {
	Program prg = new Program_class(blk);
	return prg;
}

Block append_block(Block blk, Expression e1) {
	blk->append_expr(e1);
	return blk;
};

Block single_block(Expression e1) {
	Block blk = new Block_class();
	blk->append_expr(e1);
	return blk;
};

Expression fbin_op(Expression e1, Expression e2, int op) {
	bin_op* expr = new bin_op(e1, e2, op);
	return expr;
};

Expression funi_op(Expression e1, int op) {
	uni_op* expr = new uni_op(e1, op);
	return expr;
};

Expression assign(Symbol var, Expression e1) {
	Assign* expr = new Assign(var, e1);
	return expr;
};

Expression int_const(Symbol var) {
	Int_const* iconst = new Int_const(var);
	return iconst;
};

Expression object(Symbol var) {
	Object* obj = new Object(var);
	return obj;
};

Expression let(Symbol var, Expression e1) {
	Let* expr = new Let(var, e1);
	return expr;
};

Expression cond(Expression cond, Block etrue, Block efalse) {
	Cond* ifcond = new Cond(cond, etrue, efalse);
	return ifcond;
};

Expression print(Expression e1) {
	Print* expr = new Print(e1);
	return expr;
}

Expression read(Symbol var) {
	Read* expr = new Read(var);
	return expr;
}

Expression loop(Expression cond, Block e1) {
	Loop* expr = new Loop(cond, e1);
	return expr;
}

Expression str_const(Symbol value) {
	Str_const* str = new Str_const(value);
	return str;
}
