%{
    #include "y.tab.h"
    #include <stdlib.h>
    #include "mem.h"

    void yyerror(char *);
%}
%option yylineno



%%
[ \t]
[0-9]+(\.[0-9]+)?          					{ yylval.num = atof(yytext); return NUMBER; }
("add")|("ADD")                            		{ return ADD; }
("sub")|("SUB")                         					{ return SUB; }
("mul")|("MUL")                          					{ return MUL; }
("div")|("DIV")                        					{ return DIV; }
("push")|("PUSH")												{ return VAR_KEYWORD; }
("print")|("PRINT")                                 { return PRINT_KEYWORD; }
("pop")|("POP")                                 { return POP_KEYWORD; }

[a-zA-Z0-9]+  												{ yylval.index = add_variable(yytext); return VARIABLE; }
[\n]                        					{ return EOL; }
. 

%%

int yywrap(void) {
    return 1;
}
