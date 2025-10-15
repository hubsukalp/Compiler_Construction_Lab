%{
#include <stdio.h>
#include <string.h>
int count = 0;
%}

%%

[a-zA-Z]+ {
    if (yytext[0] == 'a' || yytext[0] == 'A') {
        count++;
    }
}

[ \t\n]+   ;        
.          ;        
%%

int main() {
    yylex();
    printf("Number of words starting with 'a' or 'A': %d\n", count);
    return 0;
}
