%{
#include <stdio.h>
int yylex();
void yyerror(const char *s);
%}

%token FOR ID NUM RELOP ASSIGN INC DEC
%token LPAREN RPAREN LBRACE RBRACE SEMI

%%
stmt : FOR LPAREN init SEMI cond SEMI inc RPAREN body
     { printf("\nValid FOR loop syntax.\n"); }
     ;

init : ID ASSIGN NUM ;

cond : ID RELOP NUM ;

inc  : ID INC
     | INC ID
     | ID DEC
     | DEC ID
     ;

body : LBRACE RBRACE
     | SEMI
     | /* empty body allowed */
     ;
%%

void yyerror(const char *s){ printf("\nSyntax Error\n"); }

int main() {
    printf("Enter a FOR loop:\n");
    yyparse();
    return 0;
}
