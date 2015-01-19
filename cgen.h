#define WORD_SIZE 4
#define ZERO "$zero"		// Zero register 
#define ACC  "$a0"		// Accumulator 
#define A1   "$a1"		// For arguments to prim funcs 
#define SELF "$s0"		// Ptr to self (callee saves) 
#define T1   "$t1"		// Temporary 1 
#define T2   "$t2"		// Temporary 2 
#define T3   "$t3"		// Temporary 3 
#define SP   "$sp"		// Stack pointer 
#define FP   "$fp"		// Frame pointer 
#define RA   "$ra"		// Return address 
#define S1   "$s1"
#define V0   "$v0"		// System Call

#define JALR  "\tjalr\t"  
#define JAL   "\tjal\t"                 
#define RET   "\tjr\t"RA"\t"
#define SYSCALL	"\tsyscall\t"

#define SW    "\tsw\t"
#define LW    "\tlw\t"
#define LI    "\tli\t"
#define LA    "\tla\t"

#define MOVE  "\tmove\t"
#define NEG   "\tneg\t"
#define ADD   "\tadd\t"
#define ADDI  "\taddi\t"
#define ADDU  "\taddu\t"
#define ADDIU "\taddiu\t"
#define DIV   "\tdiv\t"
#define MUL   "\tmul\t"
#define SUB   "\tsub\t"
#define SLL   "\tsll\t"
#define BEQZ  "\tbeqz\t"
#define BRANCH   "\tb\t"
#define BEQ      "\tbeq\t"
#define BNE      "\tbne\t"
#define BLEQ     "\tble\t"
#define BLT      "\tblt\t"
#define BGT      "\tbgt\t"
#define SEQ      "\tseq\t"
#define SLT      "\tslt\t"
#define SLE      "\tsleu\t"

void load(char *dest_reg, int offset, char *source_reg, ostream& s) {
	s << LW << dest_reg << ",\t" << offset * WORD_SIZE << "(" << source_reg << ")" << endl;
}

void store(char *source_reg, int offset, char *dest_reg, ostream& s) {
	s << SW << source_reg << ",\t" << offset * WORD_SIZE << "(" << dest_reg << ")" << endl;
}


void push(char* reg, ostream& s) {
	store(reg, 0, SP, s);
	s << ADDIU << SP << ",\t" << SP << ",\t" << -WORD_SIZE << endl;
}

void pop(ostream &s) {
	s << ADDIU << SP << ",\t" << SP << ",\t" << WORD_SIZE << endl;
}
