%{
#include <stdio.h>
#include <stdlib.h>
#include "ast.hpp"
#define YYDEBUG 1

extern "C" int yylex(void);
int yyerror(char const *);

%}
%union {
	double double_value;
	void *expression;
}
	/*
%token <int_value>		INTEGER_LITERAL
	*/
%token <double_value>	DOUBLE_LITERAL
%token LPAREN RPAREN
%left ADD SUB
%left MUL DIV MOD
%right CR
%type <expression> expression
%%
statements
	: statement 
	| statements statement
	;
statement
	: expression CR
	{
		printf(">>%lf\n", ((Expr *)$1)->evaluate()->value());
	}
expression
	/*: INTEGER_LITERAL
	|*/ : DOUBLE_LITERAL
	{
		$$ = new Expr($1);
	}
	| LPAREN expression RPAREN
	{
		$$ = $2;
	}
	| expression ADD expression
	{
		$$ = new BinOpExpr(OP_ADD, (Expr *)$1, (Expr *)$3);
	}
	| expression SUB expression
	{
		$$ = new BinOpExpr(OP_SUB, (Expr *)$1, (Expr *)$3);
	}
	| expression MUL expression
	{
		$$ = new BinOpExpr(OP_MUL, (Expr *)$1, (Expr *)$3);
	}
	| expression DIV expression
	{
		$$ = new BinOpExpr(OP_DIV, (Expr *)$1, (Expr *)$3);
	}
	/*
	| expression MOD expression
	{
		$$ = $1 - $3 * (int)($1/$3);
	}
	*/
	;                 
%%
int yyerror(char const *str)
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
