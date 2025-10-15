%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>

int line_count = 0;
int space_count = 0;
int word_count = 0;
int identifier_count = 0;
int char_count = 0;
int keyword_count = 0;
int comment_count = 0;

const char *keywords[] = {
    "auto", "break", "case", "char", "const", "continue", "default",
    "do", "double", "else", "enum", "extern", "float", "for", "goto",
    "if", "int", "long", "register", "return", "short", "signed",
    "sizeof", "static", "struct", "switch", "typedef", "union",
    "unsigned", "void", "volatile", "while", "inline", "restrict", "_Bool",
    "_Complex", "_Imaginary"
};

int is_keyword(const char *word) {
    for (int i = 0; i < sizeof(keywords)/sizeof(keywords[0]); i++) {
        if (strcmp(word, keywords[i]) == 0)
            return 1;
    }
    return 0;
}
%}

%%
"//"[^'\n']*     { comment_count++; char_count += yyleng; }
"/*"(.|\n)*?"*/"               { comment_count++; char_count += yyleng; }

\n                             { line_count++; char_count += yyleng; }
[ ]+                           { space_count += yyleng; char_count += yyleng; }
\t+                            { /* Ignore tabs */ }

[a-zA-Z_][a-zA-Z0-9_]*         {
                                   if (is_keyword(yytext)) {
                                       keyword_count++;
                                   } else {
                                       identifier_count++;
                                   }
                                   word_count++;
                                   char_count += yyleng;
                               }

[^\t\n a-zA-Z0-9_]+            {
                                   word_count++;
                                   char_count += yyleng;
                               }

.                              { char_count += yyleng; }
%%

int yywrap() { return 1; }

int main(int argc, char *argv[]) {
    if (argc >= 2) {
        FILE *file = fopen(argv[1], "r");
        if (!file) {
            perror("Error opening input file");
            return 1;
        }
        yyin = file;
    } else {
        yyin = stdin;
    }

    yylex();

    if (yyin != stdin) {
        fclose(yyin);
    }

    printf("\nSummary:\n");
    printf("Lines        = %d\n", line_count);
    printf("Spaces       = %d\n", space_count);
    printf("Words        = %d\n", word_count);
    printf("Identifiers  = %d\n", identifier_count);
    printf("Keywords     = %d\n", keyword_count);
    printf("Comments     = %d\n", comment_count);
    printf("Characters   = %d\n", char_count);

    return 0;
}
