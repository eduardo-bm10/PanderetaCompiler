%{
    #include <stdio.h>
    #include<string.h>
    #include<stdlib.h>
    #include "myscanner.h"
    void extern yyerror(char* s);
%}

whitespace      [ \t\r\v\f]
linefeed        \n


%%
@([a-zA-Z]|[0-9]|"?"|"_"){2,9} {yylval.id = strdup(yytext);return IDENTIFIER;}

"SET" {yylval.set = strdup(yytext); return SET;}
"Def" {yylval.def = strdup(yytext); return DEF;}
"if" {yylval.if = strdup(yytext); return IF;}
"else" {yylval.else = strdup(yytext); return ELSE;}
"for" {yylval.for = strdup(yytext); return FOR;}

[-+]?[1-9][0-9]* {yylval.int_val = atoi(yytext);return NUMBER;}
[-+]?[1-9][0-9]*.[0-9]* {yylval.float_val = atof(yytext);return NUMBER}

"True"|"False" {yylval.bool_val = strdup(yytext);return BOOLEAN;}

"(" {yylval.oparen = strdup(yytext);return OPENPAREN}
")" {yylval.cparen = strdup(yytext);return CLOSEPAREN}
"+" {yylval.sum = strdup(yytext);return SUM;}
"-" {yylval.min = strdup(yytext); return MIN;}
"*" {yylval.mult = strdup(yytext); return MULT;}
"%" {yylval.mod = strdup(yytext); return MODULO;}
"/" {yylval.div = strdup(yytext); return DIV;}
"//" {yylval.int_div = strdup(yytext); return INT_DIV;}
"," {yylval.comma = strdup(yytext);return COMMA;}
"Neg"|"T"|"F" {yylval.bool_o = strdup(yytext);return BOOLEAN_OPERATOR;}
";"  {yylval.semicolon = strdup(yytext);return SEMICOLON}

"Abanico" {yylval.abanico = strdup(yytext);return MOVABANICO}
"Vertical" {yylval.vertical = strdup(yytext);return MOVVERTICAL}
"Percutor" {yylval.percutor = strdup(yytext);return MOVPERCUTOR}
"Golpe" {yylval.golpe = strdup(yytext);return MOVGOLPE}
"Vibrato" {yylval.vibrato = strdup(yytext);return MOVVIBRATO}
"Metronomo" {yylval.metronomo = strdup(yytext);return MOVMETRONOMO}
"println!" {yylval.print = strdup(yytext);return PRINT}
 
"A" { yylval.arriba = strdup(yytext);return HACIAARRIBA}
"B" {yylval.abajo = strdup(yytext);return HACIAABAJO}
"D" {yylval.derecha = strdupyytext);return HACIADERECHA}
"I" {yylval.izquierda = strdup(yytext);return HACIAIZQUIERDA}
"DI" {yylval.derechaizquierda = strdup(yytext);return DERECHAIZQUIERDA}
"AB" {yylval.arribaabajo = strdup(yytext);return ARRIBAABAJO}

{linefeed} {yylineo++;}
{whitespace} ;
. {invalidToken());}


%%

int yywrap(void){
    return 1;
}
void yyerror(char*s)
{
	fprintf(stderr, "ERROR ON LINE %d. %s expected.",yylineo,yytext);
}

void InvalidToken(){
    printf("ERROR ON LINE %d : \n %s\n", yylineo, yytext);
    exit(0);
}

