parser: mini_l.lex mini_l.y
	bison -d -v --file-prefix=y mini_l.y
	flex mini_l.lex
	gcc -o parser y.tab.c lex.yy.c -lfl

clean:
	rm -f parser y.tab.* y.output *~ lex.yy.cc