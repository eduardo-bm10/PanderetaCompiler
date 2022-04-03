%{
    #include <stdio.h>
    #include <string.h>

    extern void yyerror();
    extern int yylex();
    extern char* yytext;
    extern int yylineno;

    struct dataType {
        char * id_name;
        char * type;
        int line_number;
    } symbol_table[500000];

    int count=0;
    int q;
    char type[10]

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
SET DEF IF ELSE FOR TO STEP EXEC
NUMBER BOOLEAN 
OPENPAREN CLOSEPAREN 
SUM MIN MULT MODULO DIV INT_DIV 
MAYOR MENOR IGUAL MAYORIGUAL MENORIGUAL
POINT COMMA SEMICOLON
BOOLEAN_OPERATOR
PRINCIPAL MOVABANICO MOVVERTICAL MOVPERCUTOR MOVGOLPE MOVVIBRATO MOVMETRONOMO
PRINT
HACIAARRIBA HACIAABAJO HACIADERECHA HACIAIZQUIERDA DERECHAIZQUIERDA ARRIBAABAJO

%%

/* SIMBOLO INICIAL */
expression: 
definition 
| instruction end_line    

definition:
pandereta_op OPENPAREN pandereta_args CLOSEPAREN
| routine

instruction:
assignment 
| prnt_op
| arith_funct
| EXEC routine_id

body_instructions:
instruction end_line body_instructions
| instruction end_line

body:
IF condition body
| IF condition body ELSE body
| FOR IDENTIFIER TO num_value STEP num_value body
| body_instructions

condition:
BOOLEAN
| num_value MAYOR num_value
| num_value MENOR num_value
| num_value IGUAL num_value
| num_value MAYORIGUAL num_value
| num_value MENORIGUAL num_value

routine_id:
IDENTIFIER {add('F');}
| PRINCIPAL

assignment:              
SET IDENTIFIER value

routine:
DEF routine_id OPENPAREN args CLOSEPAREN body

value:      
COMMA num_value 
| COMMA bool_value 
| COMMA arith_funct
| POINT bool_funct  

args:

num_value: NUMBER { insert_type_constant("Number"); add('C'); insert_type_variable("Number");}

bool_value: BOOLEAN {insert_type_constant("Boolean"); add('C');  insert_type_variable("Boolean");}

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
PRINT OPENPAREN  CLOSEPAREN

%%

int main() 
{
    return (yyparse());
}


void insert_type_variable(*char datatype){
    strcpy(type, data_type);
    symbol_table_table[count-1].data_type=[type];
}

void insert_type_constant(*char datatype){
    strcpy(type, datatype);
}



int search(char *type){
    int i;
    for(i=count-1;i>=0;i--){
        if(strcmp(symbol_table[i].id_name, type)==0){
            return -1;
            break;
        }
    }
}
void add(char c){
    q =search;
    if(!q) {
        if( c == 'K'){
            symbol_table[count].id_name=strdup(yytext);
            symbol_table[count].data_type=strdup("N/A");
            symbol_table[count].line_number=yylineno;
            symbol_table[count].type=strdup("Keyword\t");
            count++;
        }
        else if(c=='V') {
            symbol_table[count].id_name=strdup(yytext);
            symbol_table[count].data_type=strdup("Pending");
            symbol_table[count].line_number=yylineno;
            symbol_table[count].type=strdup("Variable");
            count++;
        }
        else if(c=='F'){
            symbol_table[count].id_name=strdup(yytext);
            symbol_table[count].data_type=strdup("N/A");
            symbol_table[count].line_number=yylineno;
            symbol_table[count].type=strdup("Funcion");
            count++
        } 
        else if(c=='C'){
            symbol_table[count].id_name=strdup(yytext);
            symbol_table[count].data_type=strdup(type);
            symbol_table[count].line_number=yylineno;
            symbol_table[count].type=strdup("Constant");
            count++;
        }
    }
}
void yyerror(char*s) {
    fprintf(stderr, "SYNTAX ERROR ON LINE %d.", yylineno)
}

int yywrap(void) {
    return 1;
}