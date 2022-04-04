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

%start program

%union {
    float (float) int_val;
    float float_val;
    char* bool_val;

    char* stringconst;

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
    char* openbrack;
    char* closebrack;
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

%token IDENTIFIER 
%token STRINGCONST
%token SET 
%token DEF 
%token IF 
%token ELSE 
%token FOR 
%token TO 
%token STEP 
%token EXEC
%token NUMBER 
%token BOOLEAN 
%token OPENPAREN 
%token CLOSEPAREN 
%token SUM 
%token MIN 
%token MULT 
%token MODULO 
%token DIV 
%token INT_DIV 
%token MAYOR 
%token MENOR 
%token IGUAL 
%token MAYORIGUAL 
%token MENORIGUAL
%token OPENBRACKET 
%token CLOSEBRACKET
%token POINT 
%token COMMA 
%token SEMICOLON
%token BOOLEAN_OPERATOR
%token PRINCIPAL 
%token MOVABANICO 
%token MOVVERTICAL 
%token MOVPERCUTOR 
%token MOVGOLPE 
%token MOVVIBRATO 
%token METRONOMO
%token PRINT
%token HACIAARRIBA 
%token HACIAABAJO 
%token HACIADERECHA 
%token HACIAIZQUIERDA 
%token DERECHAIZQUIERDA 
%token ARRIBAABAJO

%type <bool_val> condition
%type <int_val> value_1
%type <bool_val> value_2
%type <sum> operator
%%

program:
principal
| definition principal
| principal definition
;

principal:
DEF PRINCIPAL {add('F');} OPENPAREN CLOSEPAREN OPENBRACKET body CLOSEBRACKET
;

definition:
routine 
| routine  definition
;

args:
NUMBER
| BOOLEAN
| NUMBER args
| BOOLEAN args
;

instruction:
assignment 
| prnt_op
| arith_funct
| EXEC IDENTIFIER OPENPAREN args CLOSEPAREN 
| pandereta_op OPENPAREN pandereta_args CLOSEPAREN
;

body_instructions:
instruction end_line body_instructions
| instruction end_line
;

body:
IF condition OPENBRACKET body CLOSEBRACKET
| IF condition OPENBRACKET body CLOSEBRACKET ELSE OPENBRACKET body CLOSEBRACKET
| FOR IDENTIFIER TO num_value STEP num_value OPENBRACKET body CLOSEBRACKET
| body_instructions
;

condition:
BOOLEAN
| num_value MAYOR num_value {$$ = $1 > $3;}
| num_value MENOR num_value {$$ = $1 < $3;}
| num_value IGUAL num_value {$$ = $1 == $3;}
| num_value MAYORIGUAL num_value {$$ = $1 >= $3;}
| num_value MENORIGUAL num_value {$$ = $1 <= $3;}
;

assignment:              
SET IDENTIFIER value_1 {$2 = $3;}
| SET IDENTIFIER value_2
;

routine:
DEF IDENTIFIER {add('F');} OPENPAREN args CLOSEPAREN OPENBRACKET body CLOSEBRACKET
| DEF IDENTIFIER {add('F');} OPENPAREN CLOSEPAREN OPENBRACKET body CLOSEBRACKET
;

value_1:      
COMMA num_value {$$=$2;}
| COMMA arith_funct {$$=$2;}
;

value_2:
COMMA bool_value {$$=$2;}
| POINT bool_funct  {$$=$2;}
;

num_value: NUMBER { insert_type_constant("Number"); add('C'); insert_type_variable("Number");}
;

bool_value: BOOLEAN {insert_type_constant("Boolean"); add('C');  insert_type_variable("Boolean");}
;

operator:
SUM {$$='+';}
| MIN {$$='-';}
| MULT {$$='*';}
| MODULO {$$='%';}
| DIV {$$='/';}
| INT_DIV {$$='/';}
;

arith_funct: 
num_value
| num_value operator arith_funct
| OPENPAREN arith_funct CLOSEPAREN 
;

bool_funct: BOOLEAN_OPERATOR

end_line:
SEMICOLON
;

pandereta_op:
MOVABANICO
| MOVVERTICAL
| MOVPERCUTOR
| MOVGOLPE
| MOVVIBRATO
| METRONOMO
;

pandereta_args:
HACIAARRIBA
| HACIAABAJO
| HACIADERECHA
| HACIAIZQUIERDA
| DERECHAIZQUIERDA
| ARRIBAABAJO
;

constantes:
NUMBER 
| BOOLEAN
| STRINGCONST
| NUMBER constantes
| BOOLEAN constantes
| STRINGCONST constantes
;

print_args:
constantes
| IDENTIFIER
| constantes print_args
| IDENTIFIER print_args
;

prnt_op:
PRINT OPENPAREN print_args CLOSEPAREN
;


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
    fprintf(stderr, "%s ERROR ON LINE %d.", s, yylineno)
}

int yywrap(void) {
    return 1;
}