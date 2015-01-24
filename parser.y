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
	Program prog;
	Expression expr;
	Block block_expr;
	Formals formals;
	Function func;
	VecExpr vec_exp;
	Symbol symbol;
    int integer;
};

%token LET 256 IF 257 THEN 258 ELSE 259 FI 260 END 261
%token ASSIGN 262 WHILE 263 LOOP 264 DO 265
%token <integer> INT_CONST 271
%token <symbol> OBJECTID 272 STR_CONST 273 TYPEID 274

%type <prog> input
%type <block_expr> block
%type <expr> exp
%type <formals> formals
%type <func> func
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
	| LET TYPEID OBJECTID ASSIGN exp 			{ $$ = let($3, $2, $5); }
	| LET TYPEID OBJECTID '[' INT_CONST ']'     { $$ = array_let($3, $2, $5); }
	| OBJECTID ASSIGN exp 				{ $$ = assign($1, $3); }
	| OBJECTID '[' exp ']' ASSIGN exp   { $$ = array_assign($1, $3, $6); }
	| WHILE '(' exp ')' DO '{' block '}' LOOP 	{ $$ = loop($3, $7); }
	| IF exp THEN '{' block '}' ELSE '{' block '}' FI { $$ = cond($2, $5, $9); }
	| exp '+' exp					{ $$ = binary($1, $3, '+'); }
	| exp '-' exp					{ $$ = binary($1, $3, '-'); }
	| exp '*' exp					{ $$ = binary($1, $3, '*'); }
	| exp '/' exp					{ $$ = binary($1, $3, '/'); }
	| '~' exp					{ $$ = unary($2, '~'); }
	| exp '<' exp					{ $$ = binary($1, $3, '<'); }
	| exp '>' exp					{ $$ = binary($3, $1, '<'); }
	| exp '=' exp					{ $$ = binary($1, $3, '='); }
	| '(' exp ')'					{ $$ = $2; }
	| OBJECTID					{ $$ = object($1); }
    | OBJECTID '[' exp ']'      { $$ = array_access($1, $3); }
	| INT_CONST					{ $$ = int_const($1); }
	| STR_CONST					{ $$ = str_const($1); }

;

%%

void yyerror(char *s) {
	printf("Error : %s\n", s);
}

