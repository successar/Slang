%{
#include <math.h>
#include <stdio.h>
#include <iostream>
#include "ast.h"
using namespace std;

extern int lineno;

#define YYLTYPE int
#define yylloc lineno

extern int yylex();
extern FILE* fin;
void yyerror(char*);
Program root = program();
int errs = 0;
%}

%union {
	Program prog;
	Expression expr;
	Block block_expr;
	Formals formals;
	Function func;
	Struct str;
	VecExpr vec_exp;
	Symbol symbol;
    int integer;
};

%token LET 256 IF 257 THEN 258 ELSE 259 FI 260 END 261
%token ASSIGN 262 WHILE 263 LOOP 264 DO 265 STRUCT 266 SIZEOF 267
%token <integer> INT_CONST 271
%token <symbol> OBJECTID 272 STR_CONST 273 TYPEID 274

%type <prog> input
%type <block_expr> block
%type <expr> exp
%type <formals> formals
%type <func> func
%type <str> struct
%type <vec_exp> args
%type <vec_exp> arg

%right ASSIGN
%nonassoc '<' '=' '>'
%left '+' '-'
%left '*' '/'
%right '~'
%left '.'

%%

input :	functions           { $$ = root; }
    |   structs functions	{ $$ = root; }
;

structs : struct        { root->append_struct($1); }
    |   structs struct  { root->append_struct($2); }
;

struct : STRUCT TYPEID '{' formals '}'    { $$ = structt($2, $4); }

functions : func	    { root->append_function($1); }
	|   functions func	{ root->append_function($2); }
;

func : TYPEID OBJECTID '(' formals ')' '{' block '}'	{ $$ = function($2, $1, $4, $7); }
;

formals : TYPEID OBJECTID	        { $$ = single_formal($2, $1); }
	|   formals ',' TYPEID OBJECTID	{ $$ = append_formal($1, $4, $3); }
;

block : ';'	            { $$ = no_block(); }
	|   exp ';'         { $$ = single_block($1); }
	|   block exp ';'   { $$ = append_block($1, $2) ; }
;

args : 		{ $$ = no_exp(); }
	|   arg	{ $$ = $1; }
;

arg :	exp	        { $$ = single_exp($1); }
	|   arg ',' exp	{ $$ = append_exp($1, $3); }

exp :	OBJECTID '(' args ')' 				            { $$ = call($1, $3); }
    |   TYPEID OBJECTID                                 { $$ = let($2, $1); }
	|   TYPEID OBJECTID '[' INT_CONST ']'               { $$ = array_let($2, $1, $4); }
	|   OBJECTID ASSIGN exp 				            { $$ = assign($1, $3); }
	|   OBJECTID '[' exp ']' ASSIGN exp                 { $$ = array_assign($1, $3, $6); }
	|   exp '.' OBJECTID ASSIGN exp                     { $$ = struct_assign($1, $3, $5); }
	|   WHILE '(' exp ')' '{' block '}'	LOOP            { $$ = loop($3, $6); }
	|   IF exp THEN '{' block '}' ELSE '{' block '}' FI { $$ = cond($2, $5, $9); }
	|   exp '+' exp					{ $$ = binary($1, $3, '+'); }
	|   exp '-' exp					{ $$ = binary($1, $3, '-'); }
	|   exp '*' exp					{ $$ = binary($1, $3, '*'); }
	|   exp '/' exp					{ $$ = binary($1, $3, '/'); }
	|   '~' exp					    { $$ = unary($2, '~'); }
	|   exp '<' exp					{ $$ = binary($1, $3, '<'); }
	|   exp '>' exp					{ $$ = binary($3, $1, '<'); }
	|   exp '=' exp					{ $$ = binary($1, $3, '='); }
	|   '(' exp ')'					{ $$ = $2; }
	|   SIZEOF '(' TYPEID ')'       { $$ = size_of($3); }
	|   OBJECTID					{ $$ = object($1); }
    |   OBJECTID '[' exp ']'        { $$ = array_access($1, $3); }
    |   exp '.' OBJECTID            { $$ = struct_access($1, $3); }
	|   INT_CONST					{ $$ = int_const($1); }
	|   STR_CONST					{ $$ = str_const($1); }
	|   error
;

%%

void yyerror(char *s) {
	printf("%s at line : %d\n", s, lineno);
	errs++;
}

