%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int yylex(void);
void yyerror(const char *s);
%}

%token NUMBER
%token PLUS MINUS MULT DIV MOD POW LPAREN RPAREN

// Operator precedence & associativity
%left PLUS MINUS
%left MULT DIV MOD
%right POW
%left LPAREN RPAREN

%%

line:
    /* empty */
  | line expr '\n'   { printf("Result: %d\n", $2); }
  | line error '\n'  { yyerror("Invalid expression, try again."); yyerrok; }
  ;

expr:
    NUMBER               { $$ = $1; }
  | expr PLUS expr       { $$ = $1 + $3; }
  | expr MINUS expr      { $$ = $1 - $3; }
  | expr MULT expr       { $$ = $1 * $3; }
  | expr DIV expr        {
                            if ($3 == 0) {
                                yyerror("Division by zero");
                                $$ = 0;
                            } else $$ = $1 / $3;
                          }
  | expr MOD expr        {
                            if ($3 == 0) {
                                yyerror("Modulo by zero");
                                $$ = 0;
                            } else $$ = $1 % $3;
                          }
  | expr POW expr        { $$ = (int)pow($1, $3); }
  | LPAREN expr RPAREN   { $$ = $2; }
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Desk Calculator (type Ctrl+C to exit)\n");
    yyparse();
    return 0;
}
