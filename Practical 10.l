%{
#include "y.tab.h"
#include <string.h>
%}

%option noyywrap

%%
[a-zA-Z][a-zA-Z0-9]*   { yylval.s = strdup(yytext); return ID; }
[0-9]+                 { yylval.s = strdup(yytext); return NUM; }
"="                    { return ASSIGN; }
[+\-*/()]              { return yytext[0]; }
[ \t\n]                ;
.                      ;
%%
