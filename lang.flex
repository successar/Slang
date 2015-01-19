%x STRING ERR_STRING

%{
#include <iostream>
#include "ast.h"
#include "parser-header.h"
using namespace std;

extern FILE* fin;

#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

#define MAX_STR_LENGTH 1025
char string_buf[MAX_STR_LENGTH];
int string_chars = 0;
char* string_buf_ptr;

%}

%option noyywrap
DIGIT	[0-9]
ALPHA	[a-zA-Z]
ALPHA_LOWER	[a-z]
ALPHA_UPPER	[A-Z] 

LETK	[L|l][E|e][T|t]
IFK	[I|i][F|f]
ELSEK    [e|E][l|L][s|S][e|E]
FIK      [f|F][i|I]
THENK	[T|t][H|h][E|e][N|n]
WHILEK	[W|w][H|h][I|i][L|l][E|e]
LOOPK	[L|l][O|o][O|o][P|p]
DOK	[D|d][O|o]
ENDK	[E|e][N|n][D|d]

ASSIGNK	<-

PRINTK	[p|P][r|R][i|I][n|N][t|T]
READK	[R|r][e|E][a|A][d|D]

%%

","	 { return (','); }
"+"      { return ('+'); }
"-"      { return ('-'); }
"*"      { return ('*'); }
"/"      { return ('/'); }
";"      { return (';'); }
"~"      { return ('~'); }
"<"      { return ('<'); }
"="      { return ('='); }
"{"      { return ('{'); }
"}"      { return ('}'); }
"("      { return ('('); }
")"      { return (')'); }
{ASSIGNK} { return ASSIGN; }
[ \t\r\f\v\n]+ {}

{ELSEK}           { return ELSE; }
{FIK}             { return FI; }
{IFK}             { return IF; }
{LETK}            { return LET; }
{THENK}           { return THEN; }
{READK}           { return READ; }
{PRINTK}	  { return PRINT; }
{WHILEK}	  { return WHILE; }
{LOOPK}		  { return LOOP; }
{DOK}		  { return DO; }
{ENDK}		  { return END; }

<INITIAL>{\"  {
 string_buf_ptr = string_buf; 
string_chars = 0;  
BEGIN(STRING); }
}

<STRING>{

\"       { 
*string_buf_ptr++ = '\0';
yylval.symbol = new symtab_entry(string_buf);
BEGIN(INITIAL);
return STR_CONST;
 }

"\0"   {
if(string_chars != 1024){
*string_buf_ptr++ = '\0'; string_chars++;}

else {
printf("String constant too long");
BEGIN(ERR_STRING);
}}

\n   {
printf("Unterminated string constant");
BEGIN(INITIAL);
}

\0/[^\"] {
printf("String contains null character");
BEGIN(ERR_STRING);
}


\\n  {
if(string_chars != 1024){
*string_buf_ptr++ = '\n'; string_chars++;}

else {
printf("String constant too long");
BEGIN(ERR_STRING);
}}


\\t  {
if(string_chars != 1024){
*string_buf_ptr++ = '\t'; string_chars++;}

else {
printf("String constant too long");
BEGIN(ERR_STRING);
}}


\\b  {
if(string_chars != 1024){
*string_buf_ptr++ = '\b'; string_chars++;}

else {
printf("String constant too long");
BEGIN(ERR_STRING);
}}


\\f  {
if(string_chars != 1024){
*string_buf_ptr++ = '\f'; string_chars++;}

else {
printf("String constant too long");
BEGIN(ERR_STRING);
}}

\\(.|\n)  {
if(string_chars != 1024){
if(yytext[1] == '\0') {
printf("String contains null character");
BEGIN(ERR_STRING);
}
*string_buf_ptr++ = yytext[1]; string_chars++;}

else {
printf("String constant too long");
BEGIN(ERR_STRING);
}}

[^\\\n\"\0]+   {
char *yptr = yytext;
while(*yptr){ 
if(string_chars != 1024){
*string_buf_ptr++ = *yptr++; 
 string_chars++;}

else {
printf("String constant too long");
BEGIN(ERR_STRING);
}}}

<<EOF>> {
printf("EOF in string constant");
BEGIN(INITIAL); }
}

<ERR_STRING>{

[^\n\"]*\n    BEGIN(INITIAL);
[^\n\"]*\"    BEGIN(INITIAL);

}

  
[0-9]+	 { yylval.symbol = new symtab_entry(yytext)  ; return INT_CONST; }
[a-z][A-Za-z0-9_]+ { yylval.symbol = new symtab_entry(yytext) ; return OBJECTID; }
[A-Z][A-Za-z0-9_]+ { yylval.symbol = new symtab_entry(yytext); return TYPEID; }

. { cout << "ERROR : " << yytext; }
%%

