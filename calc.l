%{
	#include <stdio.h>
	#include <string.h>
	#include "y.hpp"

int yywrap(void) {
    return 1;
}
%}

%%
"("		return LPAREN;
")"		return RPAREN;

"+"		return ADD;
"-"		return SUB;
"*"		return MUL;
"/"		return DIV;
	/*
"%"		return MOD;
	*/
"\n"	return CR;
[1-9][0-9]* {
    double val;
	sscanf(yytext, "%lf", &val);
    yylval.double_value = val;
    return DOUBLE_LITERAL;//INTEGER_LITERAL;
}
0x[1-9A-Fa-f][0-9A-Fa-f]* {
    double val; int temp;
	sscanf(yytext, "%x", &temp);
	val = temp;
    yylval.double_value = val;
    return DOUBLE_LITERAL;//INTEGER_LITERAL;
}
0b[01]* {
	double val = 0;
	for(int i = 0; i < strlen(yytext)-2; i++) {
		val += ((yytext[strlen(yytext)-(i+1)]=='0')?0:1 << i);
	}
    yylval.double_value = val;
    return DOUBLE_LITERAL;//INTEGER_LITERAL;
}
[0-9]*\.[0-9]* {
    double val;
    sscanf(yytext, "%lf", &val);
    yylval.double_value = val;
    return DOUBLE_LITERAL;
}
%%
