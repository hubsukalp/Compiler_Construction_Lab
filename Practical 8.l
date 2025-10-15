%{
#include "y.tab.h"
#include <stdlib.h>
%}

%option noyywrap

%%

[0-9]+          { yylval = atoi(yytext); return NUMBER; }
[ \t]           ;   // ignore spaces
\n              { return '\n'; }
"+"             { return PLUS; }
"-"             { return MINUS; }
"*"             { return MULT; }
"/"             { return DIV; }
"%"             { return MOD; }
"^"             { return POW; }
"("             { return LPAREN; }
")"             { return RPAREN; }
.               { return yytext[0]; }

%%
