%{
#include "y.tab.h"
%}

%option noyywrap

%%
"for"       { return FOR; }
"("         { return LPAREN; }
")"         { return RPAREN; }
"{"         { return LBRACE; }
"}"         { return RBRACE; }
";"         { return SEMI; }
"++"        { return INC; }
"--"        { return DEC; }
"="         { return ASSIGN; }
"<"|">"     { return RELOP; }
[0-9]+      { return NUM; }
[a-zA-Z_][a-zA-Z0-9_]*   { return ID; }
[ \t\n]+    ;       /* Ignore whitespaces and newlines */
.           { return yytext[0]; }
%%
