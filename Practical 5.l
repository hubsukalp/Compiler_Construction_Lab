%{
#include <stdio.h>
#include <string.h>

void decimal_to_hex(int num) {
    char hex[100];
    int i = 0, remainder;

    if(num == 0) {
        printf("0x0\n");
        return;
    }
    while(num != 0) {
        remainder = num % 16;
        if(remainder < 10)
            hex[i++] = remainder + '0';
        else
            hex[i++] = remainder - 10 + 'A';
        num = num / 16;
    }
    printf("0x");
    int j;
    for(j = i - 1; j >= 0; j--)
        printf("%c", hex[j]);
    printf("\n");
}

int string_to_int(char* str) {
    int result = 0;
    for(int i = 0; str[i] != '\0'; i++) {
        result = result * 10 + (str[i] - '0');
    }
    return result;
}
%}

%%
[0-9]+  {
            int num = string_to_int(yytext);
            decimal_to_hex(num);
        }

.|\n    { ECHO; }
%%

int main() {
    yylex();
    return 0;
}
int yywrap() {
    return 1;
}
