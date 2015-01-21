%{
#include <math.h>
#include <stdio.h>
#include <iostream>
#include "ast.h"
using namespace std;

extern int yylex();
extern FILE* fin;
void yyerror(char*);
Program root = program();
%}

%union {
	Program prg;
	Expression expr;	
	Block blk_expr;
	Formals forms;
	Function fun;
	VecExpr vec_exp;
	Symbol symbol;
};

%token LET 256 IF 257 THEN 258 ELSE 259 FI 260 END 261
%token ASSIGN 262 WHILE 263 LOOP 264 DO 265
%token <symbol> INT_CONST 271 OBJECTID 272 STR_CONST 273 TYPEID 274
%token PRINT_INT 281 PRINT_STR 282 READ_INT 283 READ_STR 284

%type <prg> input
%type <blk_expr> block
%type <expr> exp
%type <forms> formals
%type <fun> func
%type <vec_exp> args
%type <vec_exp> arg

%right ASSIGN
%nonassoc '<' '=' '>'
%left '+' '-'
%left '*' '/'
%right '~'

%%

input :	functions	{ $$ = root; }
;

functions : func	{ root->append_function($1); }
	| functions func	{ root->append_function($2); }
;

func : TYPEID OBJECTID '(' formals ')' '{' block '}' END	{ $$ = function($2, $1, $4, $7); }
;

formals : TYPEID OBJECTID	{ $$ = single_formal($2, $1); }
	| formals ',' TYPEID OBJECTID	{ $$ = append_formal($1, $4, $3); }
;

block : ';'	{ $$ = no_block(); }
	| exp ';' { $$ = single_block($1); }
	| block exp ';' { $$ = append_block($1, $2) ; }
;

args : 		{ $$ = no_exp(); }
	| arg	{ $$ = $1; }
;

arg :	exp	{ $$ = single_exp($1); }
	| arg ',' exp	{ $$ = append_exp($1, $3); }

exp :	OBJECTID '(' args ')' 				{ $$ = call($1, $3); }
	|LET OBJECTID ASSIGN exp 			{ $$ = let($2, $4); }
	| OBJECTID ASSIGN exp 				{ $$ = assign($1, $3); }
	| WHILE '(' exp ')' DO '{' block '}' LOOP 	{ $$ = loop($3, $7); }
	| IF exp THEN '{' block '}' ELSE '{' block '}' FI { $$ = cond($2, $5, $9); }
	| READ_INT OBJECTID				{ $$ = read($2, 'i'); }
	| READ_STR OBJECTID				{ $$ = read($2, 's'); }
	| PRINT_INT '(' exp ')'				{ $$ = print($3, 'i'); }
	| PRINT_STR '(' exp ')'				{ $$ = print($3, 's'); }
	| exp '+' exp					{ $$ = fbin_op($1, $3, '+'); }
	| exp '-' exp					{ $$ = fbin_op($1, $3, '-'); }
	| exp '*' exp					{ $$ = fbin_op($1, $3, '*'); }
	| exp '/' exp					{ $$ = fbin_op($1, $3, '/'); }
	| '~' exp					{ $$ = funi_op($2, '~'); }
	| exp '<' exp					{ $$ = fbin_op($1, $3, '<'); }
	| exp '>' exp					{ $$ = fbin_op($3, $1, '<'); }
	| exp '=' exp					{ $$ = fbin_op($1, $3, '='); }
	| '(' exp ')'					{ $$ = $2; }
	| OBJECTID					{ $$ = object($1); }
	| INT_CONST					{ $$ = int_const($1); }	
	| STR_CONST					{ $$ = str_const($1); }

;

%%

void yyerror(char *s) {
	printf("Error : %s\n", s);
}
		
