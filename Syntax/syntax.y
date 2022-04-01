%{
    #include <stdio.h>
    #include <string.h>

    extern void yyerror();
    extern int yylex();
    extern char* yytext;
    extern int yylineno;
}%

%define parse.lac full
%define parse.error verbose

%start expression

%union {
    float (float) int_val;
    float float_val;
    char* bool_val;

    char* set;
    char* def;
    char* if;
    char* else;
    char* for;

    char* oparen;
    char* cparen;
    char* sum;
    char* min;
    char* mult;
    char* mod;
    char* div;
    char* int_div;
    char* comma;
    char* bool_o;
    char* semicolon;

    char* abanico;
    char* vertical;
    char* percutor;
    char* golpe;
    char* vibrato;
    char* metronomo;
    char* print;

    char* arriba;
    char* abajo;
    char* derecha;
    char* izquierda;
    char* derechaizquierda;
    char* arribaabajo;

}

%token 
IDENTIFIER 
SET DEF IF ELSE FOR 
NUMBER BOOLEAN 
OPENPAREN CLOSEPAREN 
SUM MIN MULT MODULO DIV INT_DIV 
POINT COMMA SEMICOLON
BOOLEAN_OPERATOR
MOVABANICO MOVVERTICAL MOVPERCUTOR MOVGOLPE MOVVIBRATO MOVMETRONOMO
PRINT
HACIAARRIBA HACIAABAJO HACIADERECHA HACIAIZQUIERDA DERECHAIZQUIERDA ARRIBAABAJO

%%

/* SIMBOLO INICIAL */
expression: 
instruction end_line    

instruction:
assign 
| pandereta_op OPENPAREN pandereta_args CLOSEPAREN
| prnt_op
| arith_funct

assign:              
SET IDENTIFIER value

value:      
COMMA num_value 
| COMMA bool_value 
| COMMA arith_funct
| POINT bool_funct  

num_value: NUMBER

bool_value: BOOLEAN

operator:
SUM
| MIN
| MULT
| MODULO
| DIV
| INT_DIV

arith_funct: 
num_value 
| num_value operator arith_funct
| OPENPAREN arith_funct CLOSEPAREN 

bool_funct: BOOLEAN_OPERATOR

end_line:
SEMICOLON

pandereta_op:
MOVABANICO
| MOVVERTICAL
| MOVPERCUTOR
| MOVGOLPE
| MOVVIBRATO
| MOVMETRONOMO

pandereta_args:
HACIAARRIBA
| HACIAABAJO
| HACIADERECHA
| HACIAIZQUIERDA
| DERECHAIZQUIERDA
| ARRIBAABAJO

prnt_op:
PRINT OPENPAREN CLOSEPAREN

%%

int main() 
{
    return (yyparse());
}

void yyerror(char*s) {
    fprintf(stderr, "SYNTAX ERROR ON LINE %d.", yylineno)
}

int yywrap(void) {
    return 1;
}