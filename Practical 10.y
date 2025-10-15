%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
int yyerror(char *s);

int tempCount = 1;
char* newTemp() {
    static char buf[10];
    sprintf(buf, "t%d", tempCount++);
    return strdup(buf);
}
%}

%union {
    char *s;
}

%token <s> ID NUM
%token ASSIGN
%type <s> expr stmt

%left '+' '-'
%left '*' '/'

%%

stmt : ID ASSIGN expr
        { printf("\nIntermediate Code:\n%s = %s\n", $1, $3); }
     ;

expr : expr '+' expr
        { char *t = newTemp(); printf("%s = %s + %s\n", t, $1, $3); $$ = t; }
     | expr '-' expr
        { char *t = newTemp(); printf("%s = %s - %s\n", t, $1, $3); $$ = t; }
     | expr '*' expr
        { char *t = newTemp(); printf("%s = %s * %s\n", t, $1, $3); $$ = t; }
     | expr '/' expr
        { char *t = newTemp(); printf("%s = %s / %s\n", t, $1, $3); $$ = t; }
     | '(' expr ')'
        { $$ = $2; }
     | ID
        { $$ = strdup($1); }
     | NUM
        { $$ = strdup($1); }
     ;

%%

int main() {
    printf("Enter an arithmetic expression:\n");
    yyparse();
    return 0;
}

int yyerror(char *s) {
    printf("Error: %s\n", s);
    return 0;
}
