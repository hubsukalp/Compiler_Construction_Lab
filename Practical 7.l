%{
#include "y.tab.h"
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[ \t]+      ;
"+"         return PLUS;
"*"         return MULT;
\n          return '\n';
.           ;

%%

int yywrap() {
    return 1;
}
