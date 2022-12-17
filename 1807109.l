%{
	#include <assert.h>
	#include <stdlib.h>
	#include <string.h>
	#include "1807109.tab.h"
	void yyerror(char *);
%}

variable [a-zA-Z]
function [func_][a-zA-Z0-9_]+
HEADER []*[<][a-zA-Z0-9]+.[h][>]
IN [0-9]+
FL {IN}*"."{IN}+
STR [a-zA-Z0-9]+
SLC [#][]*+[a-zA-Z0-9. ]*
MLC [#][#][]*[a-zA-Z0-9. \n]*[]*[#][#]


%%

"IMPORT" 	{ fprintf(stderr," 'IMPORT' keyword is used for the header file\n"); return IMPORT;}
{HEADER} 	{ fprintf(stderr," (%s) is a header file\n",yytext); }
"BODY" 		{fprintf(stderr," Program Started from here\n"); return BODY;}
"JODI" 		{fprintf(stderr," '%s' like 'if' keyword\n",yytext);return JODI;}
"NAHOLE" 	{fprintf(stderr," '%s' like 'else' keyword\n",yytext); return NAHOLE;}
"OTHOBA" 	{fprintf(stderr," '%s' like 'else if' keyword\n",yytext); return OTHOBA;}
"FLOOP" 	{fprintf(stderr," '%s' like 'for' keyword\n",yytext); return FLOOP;}
"WLOOP" 	{fprintf(stderr," '%s' like 'while' keyword\n",yytext); return WLOOP;}
"CHNG" 		{fprintf(stderr," '%s' like 'switch' keyword\n",yytext); return CHNG;}
"CASE" 		{fprintf(stderr," '%s' like 'case' keyword\n",yytext); return CASE;}
"INTEGER" 	{fprintf(stderr," 'INTEGER' like 'int' type \n"); return INTEGER;}
"END" 		{fprintf(stderr," 'END' denotes ending of a line\n"); return END;}
"KOLON" 	{fprintf(stderr," 'KOLON' denotes start of a line\n"); return *yytext;}
"TAKE"	    {fprintf(stderr," 'TAKE' denotes input value\n"); return SCAN;}
"PRINT" 	{fprintf(stderr," 'PRINT' denotes show the line\n"); return PRINT;}
"DEFINE" 	{fprintf(stderr," 'DEFINE' denotes 'def' keyword\n");}
"HEADER" 	{fprintf(stderr," 'HEADER' denotes 'header.h'\n");}
"ASSIGN" 	{fprintf(stderr," 'ASSIGN' denotes = keyword\n");}
"SINE" 		{fprintf(stderr," 'SINE' denotes 'sin' keyword\n"); return SINE;}
"COSINE" 	{fprintf(stderr," 'COSINE' denotes 'cos' keyword\n"); return COSINE;}
"TANGENT" 	{fprintf(stderr," 'TANGENT' denotes 'tan' keyword\n"); return TANGENT;}
"LON" 		{fprintf(stderr," 'LON' denotes 'ln' keyword\n"); return LON;}
"LB10" 		{fprintf(stderr," 'LB10' denotes 'log10' keyword\n");return LB10;}
"GCD" 		{fprintf(stderr," 'GCD' GCD keyword\n"); return GCD;}
"LCM" 		{fprintf(stderr," 'LCM' LCM keyword\n"); return LCM;}
"FACTORIAL" {fprintf(stderr," 'FACTORIAL' FACTORIAL keyword\n"); return FACTORIAL;}
"GT" 		{fprintf(stderr," 'GT' denotes greater than > keyword\n"); return GT;}
"LT" 		{fprintf(stderr," 'LT' denotes less than < keyword\n"); return LT;}
"EQL" 		{fprintf(stderr," 'EQL' denotes equal == keyword\n"); return EQL;}
"GEQL" 		{fprintf(stderr," 'GEQL' denotes equal >= keyword\n"); return GEQL;}
"LEQL" 		{fprintf(stderr," 'LEQL' denotes equal <= keyword\n"); return LEQL;}
"AND" 		{fprintf(stderr," 'AND' denotes logical && keyword\n"); return AND;}
"OR" 		{fprintf(stderr," 'OR' denotes logical || keyword\n"); return OR;}
"NOT" 		{fprintf(stderr," 'NOT' denotes logical ! keyword\n"); return NOT;}
"INCR" 		{fprintf(stderr," 'INCR' denotes ++ keyword\n"); return INCR;}
"DECR" 		{fprintf(stderr," 'DECR' denotes -- keyword\n"); return DECR;}
"PLUS" 		{fprintf(stderr," 'PLUS' denotes + keyword\n"); return PLUS;}
"MINUS" 	{fprintf(stderr," 'MINUS' denotes - keyword\n"); return MINUS;}
"MUL" 		{fprintf(stderr," 'mul' denotes * keyword\n");return MUL;}
"DIV" 		{fprintf(stderr," 'DIV' denotes / keyword\n");return DIV;}
"MOD" 		{fprintf(stderr," 'MOD' denotes % keyword\n");return MOD;}
"POW" 		{fprintf(stderr," 'POW' denotes ** keyword\n");return POW;}
"BREAK" 	{fprintf(stderr," 'BREAK' denotes 'break' keyword in c\n"); return BREAK;}
"DEFAULT" 	{fprintf(stderr," 'DEFAULT' denotes 'default' keyword in c\n"); return DEFAULT;}
"FUNCTION" 	{fprintf(stderr," 'FUNCTION' denotes function\n"); return FUNCTION;}
"MAX" 		{fprintf(stderr," Find maximum of two num function\n"); return MAX;}
"MIN" 		{fprintf(stderr," Find minimum of two num function\n"); return MIN;}
"(" 		{fprintf(stderr," Open first bracket\n"); return *yytext;}
")" 		{fprintf(stderr," Close first bracket\n"); return *yytext;}
"{" 		{fprintf(stderr," Open second bracket\n"); return *yytext;}
"}" 		{fprintf(stderr," Close Second bracket\n");return *yytext;}
"[" 		{fprintf(stderr," Open third bracket\n");}
"]" 		{fprintf(stderr," Close third bracket\n");}
"," 		{fprintf(stderr," Koma keyword\n"); return *yytext;}
"=" 		{fprintf(stderr," Assign keyword\n"); return *yytext;}
{SLC} 		{fprintf(stderr," (%s) is single line comment\n",yytext);return SLC;}
{MLC} 		{fprintf(stderr," (%s) is multiple line comment\n",yytext);return MLC;}

{function} 	{fprintf(stderr," (%s) is a function name\n",yytext);}
"ENDP" 		{fprintf(stderr," 'ENDP' denotes ending of a program\n"); return ENDP;}
{variable}      {
                yylval.d = *yytext - 'a';
                return VARIABLE;
                }
{IN} 		{fprintf(stderr," %s is an INTEGER\n",yytext); yylval.v = atoi(yytext); return NUMBER;}
"FLOAT" 	{fprintf(stderr," 'FLOAT' like 'float' type \n"); return FLOAT;}
{FL} 		{fprintf(stderr," %s is an FLOAT\n",yytext); yylval.f = atof(yytext); return FL;}
"CHARACTER" {fprintf(stderr," 'CHARACTER' like 'char' type \n"); return CHARACTER;}

"STRING" 	{fprintf(stderr," 'STRING' like 'string' type \n");}
{STR} 		{fprintf(stderr," '%s' is a STRING\n",yytext);}


[-:\n]     { return *yytext; }


[ \t]   ;       /* skip whitespace */

.               yyerror("Unknown character");

%%

int yywrap(void){
return 1;
}

