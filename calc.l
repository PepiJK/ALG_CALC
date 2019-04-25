/* ALG-SS19 Projekt CALC, Josef Koch - Daniel Krottendorfer */
/* ----------------------------------------------------------------------------------------------------------- */
/* Das File calc.l enthält die Definition für die lexikalische Analyse, d.h. das Zerlegen einer Eingabe */
/* in Token (z.B. Zahlen, Identifier, Operatoren, etc.). Das Tool lex erzeugt aus dieser abstrakten Definition */
/* ein passendes C-Programm.Das File besteht im Wesentlichen aus regulären Ausdrücken gefolgt von einem Block */
/*  mit C-Code, der immer dann ausgeführt wird, wenn der reguläre Ausdruck im Input-Text gematcht wird. */

%{
extern int yylval; 
extern int sym[];
extern int yyerror(char *s);
#include "y.tab.h"
%}

%%

[a-z]   {
        yylval = *yytext - 'a';
        return VARIABLE;
        }

[0-9]+  {  
        yylval = atoi(yytext);
        return INTEGER;
        }

":="    return ASSIGN;
"+"     return PLUS;
"*"     return TIMES;

"-"     return MINUS;
"/"     return DIVIDE;
"%"     return MODULO;

"\n"    return NEWLINE;

[ \t]   ;

.       yyerror("Invalid character");

%%

int yywrap() {
        return 1;
}
