PROGRAM=calc
YACC=yacc
YACC_RESULT=y.cpp
LEX=lex
LEX_RESULT=lex.yy.c
OBJ=ast.o
GARBAGE=y.output lex.yy.o
CC=gcc
CXX=g++
CFLAGS=-g
CXXFLAGS=-g

all: $(YACC_RESULT) $(LEX_RESULT) $(OBJ)
	$(CC) $(CFLAGS) -c -o lex.yy.o $(LEX_RESULT)
	$(CXX) $(CXXFLAGS) -o $(PROGRAM) lex.yy.o $(YACC_RESULT) $(OBJ)

clean:
	rm -f $(GARBAGE) $(OBJ)

$(YACC_RESULT): $(PROGRAM).y
	$(YACC) -dv -o $(YACC_RESULT) $(PROGRAM).y

$(LEX_RESULT): $(PROGRAM).l
	$(LEX) $(PROGRAM).l
