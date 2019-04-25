/* ALG-SS19 Projekt CALC, Josef Koch - Daniel Krottendorfer */
/* ----------------------------------------------------------------------------------------------------------- */
/* Das File calc.y enthält die Definition für die syntaktische Analyse, d.h. das Zusammensetzen */
/* der Token aus der lexikalischen Analyse, zu sinnvollen Sprachkonstrukten. */

%{
#include <stdio.h>
int sym[26];
int yylex();
int yyerror(char *s);
%}

%token VARIABLE ASSIGN INTEGER NEWLINE
%left PLUS
%left TIMES

%left MINUS
%left DIVIDE
%left MODULO

%%

program: program statement
  | 
  ;

statement: expr NEWLINE 
  { printf("%d\n", $1); }
  | VARIABLE ASSIGN expr NEWLINE
  { sym[$1] = $3; }
  ;

expr: INTEGER        { $$ = $1; }
  | VARIABLE         { $$ = sym[$1]; }
  | expr PLUS expr   { $$ = $1 + $3; }
  | expr TIMES expr  { $$ = $1 * $3; }

  /* Aufgabe 1 */
  | expr MINUS expr  { $$ = $1 - $3; }
  | expr DIVIDE expr  { $$ = $1 / $3; }
  | expr MODULO expr  { $$ = $1 % $3; }
  ;

%%

int yyerror(char *s) {
  fprintf(stderr, "%s\n", s);
  return 0;
}

int main() {
  yyparse();
  return 0;
}
