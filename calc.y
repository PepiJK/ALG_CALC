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

%left BRACKET_LEFT
%left BRACKET_RIGHT

%left UNAER_MINUS
%left UNAER_PLUS
%left UNAER_PLUSMINUS
%left UNAER_MINUSPLUS

%left LESS
%left LESS_EQUAL
%left EQUAL
%left NOT_EQUAL
%left GREATER_EQUAL
%left GREATER

%left MIN;
%left MAX;
%left COMMA;

%left QUESTIONMARK;
%left COLON;

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
  | expr DIVIDE expr { $$ = $1 / $3; }
  | expr MODULO expr { $$ = $1 % $3; }

  /* Aufgabe 2 */
  | BRACKET_LEFT expr BRACKET_RIGHT { $$ = $2; }

  /* Aufgabe 3 */
  | PLUS expr                 { $$ = $2; }  
  | MINUS expr                { $$ = -$2; }      
  | expr UNAER_MINUS expr     { $$ = $1 + $3; }
  | expr UNAER_PLUS expr      { $$ = $1 + $3; }
  | expr UNAER_PLUSMINUS expr { $$ = $1 - $3; }
  | expr UNAER_MINUSPLUS expr { $$ = $1 - $3; }

  /* Aufgabe 4 */
  | expr LESS expr          { $$ = $1 < $3; }
  | expr LESS_EQUAL expr    { $$ = $1 <= $3; }
  | expr EQUAL expr         { $$ = $1 == $3; }
  | expr NOT_EQUAL expr     { $$ = $1 != $3; }
  | expr GREATER_EQUAL expr { $$ = $1 >= $3; }
  | expr GREATER expr       { $$ = $1 > $3; }

  /* Aufgabe 5 */
  /* | MIN BRACKET_LEFT expr COMMA expr BRACKET_RIGHT  { if($3 < $5) $$ = $3; else $$ = $5; } */
  /* | MAX BRACKET_LEFT expr COMMA expr BRACKET_RIGHT  { if($3 > $5) $$ = $3; else $$ = $5; } */

  /* Aufgabe 6 (Aufgabe 5 erweitert) */
  | MIN BRACKET_LEFT operator_min BRACKET_RIGHT { $$ = $3; }
  | MAX BRACKET_LEFT operator_max BRACKET_RIGHT { $$ = $3; }
  
  /* Aufgabe 7 */
  | expr QUESTIONMARK expr COLON expr { if($1) $$ = $3; else $$ = $5; }
  ;

operator_min: expr { $$ = $1; }
  | operator_min COMMA expr { if($1 < $3) $$ = $1; else $$ = $3; }
  ;

operator_max: expr { $$ = $1; }
  | operator_max COMMA expr { if($1 > $3) $$ = $1; else $$ = $3; }
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
