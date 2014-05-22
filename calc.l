%{
	#include <stdio.h>
	#include "y.tab.h"

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
"%"		return MOD;
"\n"	return CR;
[1-9][0-9]* {
    double val;
	sscanf(yytext, "%lf", &val);
    yylval.double_value = val;
    return INTEGER_LITERAL;
}
0x[1-9A-Fa-f][0-9A-Fa-f]* {
    double val; int temp;
	sscanf(yytext, "%x", &temp);
	val = temp;
    yylval.double_value = val;
    return INTEGER_LITERAL;
}
[0-9]*\.[0-9]* {
    double val;
    sscanf(yytext, "%lf", &val);
    yylval.double_value = val;
    return DOUBLE_LITERAL;
}
%%
