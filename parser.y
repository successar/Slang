%{
#include <math.h>
#include <stdio.h>
#include <iostream>
#include "ast.h"
using namespace std;

extern int yylex();
extern FILE* fin;
void yyerror(char*);
Program root;
%}

%union {
	Program prg;
	Expression expr;	
	Block blk_expr;
	Symbol symbol;
};

%token LET 256 IF 257 THEN 258 ELSE 259 FI 260
%token <symbol> INT_CONST 261 OBJECTID 265 STR_CONST 271
%token ASSIGN 263 PRINT 266 READ 267 WHILE 268 LOOP 269 DO 270

%type <prg> input
%type <blk_expr> expr
%type <expr> exp

%right ASSIGN
%nonassoc '<' '=' 
%left '+' '-'
%left '*' '/'
%right '~'

%%

input :	expr { $$ = program($1); root = $$; }
;

expr : 	exp ';' { $$ = single_block($1); }
	| expr exp ';' { $$ = append_block($1, $2) ; }
;

exp :	LET OBJECTID ASSIGN exp { $$ = let($2, $4); }
	| OBJECTID ASSIGN exp { $$ = assign($1, $3); }
	| WHILE '(' exp ')' DO '{' expr '}' LOOP { $$ = loop($3, $7); }
	| IF exp THEN '{' expr '}' ELSE '{' expr '}' FI { $$ = cond($2, $5, $9); }
	| READ OBJECTID	{ $$ = read($2); }
	| PRINT '(' exp ')'	{ $$ = print($3); }
	| exp '+' exp	{ $$ = fbin_op($1, $3, '+'); }
	| exp '-' exp	{ $$ = fbin_op($1, $3, '-'); }
	| exp '*' exp	{ $$ = fbin_op($1, $3, '*'); }
	| exp '/' exp	{ $$ = fbin_op($1, $3, '/'); }
	| '~' exp	{ $$ = funi_op($2, '~'); }
	| exp '<' exp	{ $$ = fbin_op($1, $3, '<'); }
	| exp '=' exp	{ $$ = fbin_op($1, $3, '='); }
	| '(' exp ')'	{ $$ = $2; }
	| OBJECTID	{ $$ = object($1); }
	| INT_CONST	{ $$ = int_const($1); }	
	| STR_CONST	{ $$ = str_const($1); }

;

%%

void yyerror(char *s) {
	printf("Error : %s\n", s);
}
		
