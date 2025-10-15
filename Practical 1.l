%{ 
#include<stdio.h> 
%} 
%% 
ZERO|zero|Zero printf("0"); 
ONE|one|One printf("1"); 
TWO|two|Two printf("2"); 
THREE|three|Three printf("3"); 
FOUR|four|Four printf("4"); 
FIVE|five|Five printf("5"); 
SIX|six|Six printf("6"); 
SEVEN|seven|Seven printf("7"); 
EIGHT|eight|Eight printf("8"); 
NINE|nine|Nine printf("9"); 
%% 
int main() { 
yylex(); 
return 0; 
}
