%{
#include <stdio.h>
int line_number = 0;
%}

%option noyywrap

%%

.*com\n { 
    line_number++;
    char clean_line[1024];
    sscanf(yytext, "%[^\n]", clean_line);
    printf("Line %d ends with 'com': %s\n", line_number, clean_line);
}

.*\n { line_number++; }

. ;

%%

int main(int argc, char *argv[]) {
    printf("Lexical analysis started...\n");
    yylex();
    return 0;
}
