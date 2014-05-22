%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1
%}
%union {
	int			int_value;
	double		double_value;
}
%token <int_value>		INTEGER_LITERAL
%token <double_value>	DOUBLE_LITERAL
%token LPAREN RPAREN
%left ADD SUB
%left MUL DIV MOD
%right CR
%type <double_value> expression
%%
statements
	: statement 
	| statements statement
	;
statement
	: expression CR
	{
		printf(">>%lf\n", $1);
	}
expression
	: INTEGER_LITERAL
	| DOUBLE_LITERAL
	| LPAREN expression RPAREN
	{
		$$ = $2;
	}
	| expression ADD expression
	{
		$$ = $1 + $3;
	}
	| expression SUB expression
	{
		$$ = $1 - $3;
	}
	| expression MUL expression
	{
		$$ = $1 * $3;
	}
	| expression DIV expression
	{
		$$ = $1 / $3;
	}
	| expression MOD expression
	{
		$$ = $1 - $3 * (int)($1/$3);
	}
	;                 
%%
int
yyerror(char const *str)
{
	extern char *yytext;
	fprintf(stderr, "parser error near %s\n", yytext);
	return 0;
}

int main(void)
{
	extern int yyparse(void);
	extern FILE *yyin;

	yyin = stdin;
	if (yyparse()) {
		fprintf(stderr, "Error ! Error ! Error !\n");
		exit(1);
	}
}
