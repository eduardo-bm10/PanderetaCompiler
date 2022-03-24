%{
    #include <stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include "myscanner.h"
    void extern yyerror(char* s);
%}

%%
@([a-zA-Z]|[0-9]|.){2,9} {yylval.id = strdup(yytext);return IDENTIFIER;}

"SET" {yylval.set = strdup(yytext); return SET;}
"Def" {yylval.def = strdup(yytext); return DEF;}
"if" {yylval.if = strdup(yytext); return IF;}
"else" {yylval.else = strdup(yytext); return ELSE;}
"for" {yylval.for = strdup(yytext); return FOR;}

[-+]?[1-9][0-9]* {yylval.int_val = atoi(yytext);return NUMBER;}

[-+]?[1-9][0-9]*.[0-9]* {yylval.float_val = atof(yytext);return NUMBER}

"True"|"False" {yylval.bool_val = strdup(yytext);return BOOLEAN;}

"+" {yylval.sum = strdup(yytext);return SUM;}
"-" {yylval.min = strdup(yytext); return MIN;}
"*" {yylval.mult = strdup(yytext); return MULT;}
"%" {yylval.mod = strdup(yytext); return MODULO;}
"/" {yylval.div = strdup(yytext); return DIV;}
"//" {yylval.int_div = strdup(yytext); return INT_DIV;}
"," {yylval.comma = strdup(yytext);return COMMA;}
"Neg"|"T"|"F" {yylval.bool_o = strdup(yytext);return BOOLEAN_OPERATOR;}
{linefeed} {yylineo++;}
{whitespace} ;

%%

int yywrap(void){
    return 1;
}
void yyerror(char*s)
{
	fprintf(stderr, "ERROR ON LINE %d. %s expected.",yylineo,yytext);
}

