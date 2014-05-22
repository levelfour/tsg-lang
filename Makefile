PROGRAM=calc
YACC=yacc
YACC_RESULT=y.tab.c
LEX=lex
LEX_RESULT=lex.yy.c
OBJ=y.output y.tab.h 
CC=gcc

all: $(YACC_RESULT) $(LEX_RESULT)
	$(CC) -o $(PROGRAM) $(YACC_RESULT) $(LEX_RESULT)

clean:
	rm -f $(LEX_RESULT) $(YACC_RESULT) $(OBJ)

$(YACC_RESULT): $(PROGRAM).y
	$(YACC) -dv $(PROGRAM).y

$(LEX_RESULT): $(PROGRAM).l
	$(LEX) $(PROGRAM).l
