%{
    #include <stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include "myscanner.h"
    void extern yyerror(char* s);
%}

%%
@([a-zA-Z]+[0-9]+"_"+"?"){2,9} {yylval.id = strdup(yytext);return IDENTIFIER;}

"SET"+"Def"+"if"+"else"+"for" {yylval.key = strdup(yytext); return KEYWORD;}

[1-9][0-9]* {yylval.int_val = atoi(yytext);return INTEGER;}

"True"+"False" {yylval.bool_val = strdup(yytext);return BOOLEAN;}

"+" {yylval.sum = strdup(yytext);return SUM;}
"-" {yylval.min = strdup(yytext); return MIN;}
"*" {yylval.mult = strdup(yytext); return MULT;}
"%" {yylval.mod = strdup(yytext); return MODULO;}
"/" {yylval.div = strdup(yytext); return DIV;}
"//" {yylval.int_div = strdup(yytext); return INT_DIV;}
"," {yylval.assign = strdup(yytext);return ASSIGN;}
"Neg"+"T"+"F" {yylval.bool_o = strdup(yytext);return BOOLEAN_OPERATOR;}
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
