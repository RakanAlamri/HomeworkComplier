prog:
	flex calculator.l
	bison -dy calculator.y
	gcc lex.yy.c y.tab.c -o calculator_op
	./calculator_op