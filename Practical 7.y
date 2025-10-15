%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Function prototypes
void push(int val);
void binary_op(char op);
int yylex(void);
void yyerror(const char *s);
%}

%token NUMBER
%token PLUS MINUS MULT DIV MOD POW

%%

line:
    expr '\n' { printf("Result: %d\n", $1); }
  ;

expr:
    NUMBER            { $$ = $1; }
  | expr expr PLUS    { $$ = $1 + $2; }
  | expr expr MINUS   { $$ = $1 - $2; }
  | expr expr MULT    { $$ = $1 * $2; }
  | expr expr DIV     { 
                          if ($2 == 0) {
                              yyerror("Division by zero");
                              $$ = 0;
                          } else {
                              $$ = $1 / $2;
                          }
                       }
  | expr expr MOD     { 
                          if ($2 == 0) {
                              yyerror("Modulo by zero");
                              $$ = 0;
                          } else {
                              $$ = $1 % $2;
                          }
                       }
  | expr expr POW     { $$ = (int)pow($1, $2); }
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Enter a postfix expression:\n");
    yyparse();
    return 0;
}
