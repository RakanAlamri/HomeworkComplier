%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <math.h>
    void yyerror(char *);
    int yylex(void);
    extern int yyparse();
    extern int add_variable(char* var_name);
    extern int set_variable(int index, double val);
    extern int yylineno;    


    int cal[30];

int currentNumber = 0;
int numbers[100];
int total = 0;
extern double variable_values[100];
extern int variable_set[100];


int main(void) {
	int a = yyparse();
	return 0;
}

void yyerror(char *s) {
	printf("ERROR: %s\n", s);
}


%}


%union {
	int index;
	double num;
}



%token<num> NUMBER
%token DIV MUL ADD SUB
%token VAR_KEYWORD PRINT_KEYWORD,POP_KEYWORD

%token<index> VARIABLE
%token<num> EOL
%type<num> program_input
%type<num> line
%type<num> calculation
%type<num> expr
%type<num> assignment


%nonassoc UMINUS

%%
program_input:
	| program_input line
	;
	
line: 
			EOL 						 { printf("Please enter a calculation:\n"); }
		| calculation EOL  { }  | printFunc EOL  { } 
        
    ;

calculation:
		  expr
		| assignment
		;
printFunc:
		| assignment
		;
pop_func:
		| assignment
		;

		
expr:
			SUB expr					{ $$ = -$2; }
    | NUMBER            { $$ = $1; }
		| VARIABLE					{ $$ = variable_values[$1]; }
		|  DIV      { 
            if (numbers[1] == 0) { yyerror("Cannot divide by zero"); exit(1); } else {
                total = numbers[0]/numbers[1];
            }
            }
		|  MUL      {total = numbers[0]*numbers[1]; }
		| ADD     { total = numbers[0]+numbers[1];}
		| SUB    	{ total = numbers[0]-numbers[1];}
        
    ;
		
		
assignment: 
		VAR_KEYWORD calculation {
            if(currentNumber > 1){
                printf("you Cannot push another number please do pop\n");
               
            } else {

            numbers[currentNumber] =  $2;
            currentNumber++;
            }

             } | 
             PRINT_KEYWORD printFunc {
                            printf("%d",total);
             }  | 
              POP_KEYWORD pop_func {
                numbers[currentNumber-1] = 0;
                currentNumber--;
                            
             } 

%%
