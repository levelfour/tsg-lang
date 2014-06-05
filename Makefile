PROGRAM=calc
YACC=yacc
YACC_RESULT=y.cpp
LEX=lex
LEX_RESULT=lex.yy.c
OBJ=y.output y.hpp lex.yy.o
CC=gcc
CXX=g++

all: $(YACC_RESULT) $(LEX_RESULT)
	$(CC) -c -o lex.yy.o $(LEX_RESULT)
	$(CXX) -o $(PROGRAM) lex.yy.o $(YACC_RESULT)

clean:
	rm -f $(LEX_RESULT) $(YACC_RESULT) $(OBJ)

$(YACC_RESULT): $(PROGRAM).y
	$(YACC) -dv -o $(YACC_RESULT) $(PROGRAM).y

$(LEX_RESULT): $(PROGRAM).l
	$(LEX) $(PROGRAM).l
