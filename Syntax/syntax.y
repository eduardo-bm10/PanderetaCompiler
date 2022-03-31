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