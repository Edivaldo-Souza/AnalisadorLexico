CC=g++
LEX=flex++

all:analisador

analisador: lex.yy.cc
	$(CC) lex.yy.cc -o analisador

lex.yy.cc: lex.l
	$(LEX) lex.l

clean:
	rm analisador lex.yy.cc 