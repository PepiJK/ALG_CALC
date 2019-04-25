%{
#include <stdio.h>
int sym[26];
int yylex();
int yyerror(char *s);
%}

%token VARIABLE ASSIGN INTEGER NEWLINE
%left PLUS
%left TIMES

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
