%{
    #include "myscanner.h" 
%}

%%
@([a-zA-Z]+[0-9]+"_"+"?")* return IDENTIFIER;

"INT"+"BOOL" return TYPE;

"SET"+"Def" return KEYWORD;

[1-9][0-9]* return INTEGER;

"True"+"False" return BOOLEAN;

"+"+"-"+"*"+"**"+"/"+"//"+"%" return MATH_OPERATOR;

"Neg"+"T"+"F" return BOOLEAN_OPERATOR;
%%

int yywrap(void){
    return 1;
}
