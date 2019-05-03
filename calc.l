/* ALG-SS19 Projekt CALC, Josef Koch - Daniel Krottendorfer */
/* ----------------------------------------------------------------------------------------------------------- */
/* Das File calc.l enthält die Definition für die lexikalische Analyse, d.h. das Zerlegen einer Eingabe */
/* in Token (z.B. Zahlen, Identifier, Operatoren, etc.). Das Tool lex erzeugt aus dieser abstrakten Definition */
/* ein passendes C-Programm. Das File besteht im Wesentlichen aus regulären Ausdrücken gefolgt von einem Block */
/* mit C-Code, der immer dann ausgeführt wird, wenn der reguläre Ausdruck im Input-Text gematcht wird. */

%{
extern int yylval; 
extern int sym[];
extern int yyerror(char *s);
#include "y.tab.h"
%}

%%

[a-z]           {
                yylval = *yytext - 'a';
                return VARIABLE;
                }

[0-9]+          {  
                yylval = atoi(yytext);
                return INTEGER;
                }

0x[0-9a-f]+     {
                yylval = strtol(yytext, NULL, 16);
                return INTEGER;
                }               

":="    return ASSIGN;
"+"     return PLUS;
"*"     return TIMES;

"-"     return MINUS;
"/"     return DIVIDE;
"%"     return MODULO;

"("     return BRACKET_LEFT;
")"     return BRACKET_RIGHT;

"--"    return UNAER_MINUS;
"++"    return UNAER_PLUS;
"+-"    return UNAER_PLUSMINUS;
"-+"    return UNAER_MINUSPLUS;

"<"     return LESS;
"<="    return LESS_EQUAL;
"=="    return EQUAL;
"!="    return NOT_EQUAL;
">="    return GREATER_EQUAL;
">"     return GREATER;

"min"   return MIN;
"max"   return MAX;
","     return COMMA;

"?"     return QUESTIONMARK;
":"     return COLON;

"\n"    return NEWLINE;

[ \t]   ;

.       yyerror("Invalid character");

%%

int yywrap() {
        return 1;
}
