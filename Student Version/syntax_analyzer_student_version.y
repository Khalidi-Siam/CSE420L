%{

#include"symbol_info.h"

#define YYSTYPE symbol_info*

int yyparse(void);
int yylex(void);

extern FILE *yyin;


ofstream outlog;

int lines;

// declare any other variables or functions needed here


%}

%token IF ELSE FOR WHILE DO BREAK INT CHAR FLOAT DOUBLE VOID RETURN SWITCH CASE DEFAULT CONTINUE GOTO PRINTF ADDOP MULOP INCOP RELOP ASSIGNOP LOGICOP NOT LPAREN RPAREN LCURL RCURL LTHIRD RTHIRD COMMA COLON SEMICOLON ID CONST_INT CONST_FLOAT

%nonassoc  RELOP

%%

start : program
	{
		outlog<<"At line no: "<<lines<<" start : program "<<endl<<endl;
	}
	;

program : program unit
	{
		outlog<<"At line no: "<<lines<<" program : program unit "<<endl<<endl;
		outlog<<$1->getname()+"\n"+$2->getname()<<endl<<endl;
		
		$$ = new symbol_info($1->getname()+"\n"+$2->getname(),"program");
	}
	| unit
	{
		outlog<<"At line no: "<<lines<<" program : unit "<<endl<<endl;
		outlog<<$1->getname()<<endl<<endl;
		
		$$ = new symbol_info($1->getname(),"program");
	}
	;


unit : var_declaration
	{
		outlog<<"At line no: "<<lines<<" unit : var_declaration "<<endl<<endl;
		outlog<<$1->getname()<<endl<<endl;
		
		$$ = new symbol_info($1->getname(),"unit");
	}
	| func_definition
	{
		outlog<<"At line no: "<<lines<<" unit : func_definition "<<endl<<endl;
		outlog<<$1->getname()<<endl<<endl;
		
		$$ = new symbol_info($1->getname(),"unit");
	}
	;

func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement
	{
		outlog<<"At line no: "<<lines<<" func_definition : type_specifier ID LPAREN parameter_list RPAREN compound_statement "<<endl<<endl;
		outlog<<$1->getname()+" "+$2->getname()+"("+$4->getname()+")\n"+$6->getname()<<endl<<endl;
		
		$$ = new symbol_info($1->getname()+" "+$2->getname()+"("+$4->getname()+")\n"+$6->getname(),"func_def");
	}
	| type_specifier ID LPAREN RPAREN compound_statement
	{
		outlog<<"At line no: "<<lines<<" func_definition : type_specifier ID LPAREN RPAREN compound_statement "<<endl<<endl;
		outlog<<$1->getname()+" "+$2->getname()+"()\n"+$5->getname()<<endl<<endl;
		
		$$ = new symbol_info($1->getname()+" "+$2->getname()+"()\n"+$5->getname(),"func_def");
	}
	;





	

type_specifier : INT {
					outlog << "At line no: " << lines << "type_specifier : INT" <<endl<<endl;
					outlog << "int" <<endl<<endl;
					$$ = new symbol_info("int", "type_specifier");
				}
				| FLOAT {}
				| VOID {}
				;


statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement
	  {
	    	outlog<<"At line no: "<<lines<<" statement : FOR LPAREN expression_statement expression_statement expression RPAREN statement "<<endl<<endl;
			outlog<<"for("<<$3->getname()<<$4->getname()<<$5->getname()<<")\n"<<$7->getname()<<endl<<endl;
			
			$$ = new symbol_info("for("+$3->getname()+$4->getname()+$5->getname()+")\n"+$7->getname(),"stmnt");
	  }

%%

int main(int argc, char *argv[])
{
	if(argc != 2) 
	{
        // check if filename given
		cout<<"Please provide filename"<<endl;
		return 0;
	}
	yyin = fopen(argv[1], "r");
	outlog.open("my_log.txt", ios::trunc);
	
	if(yyin == NULL)
	{
		cout<<"Couldn't open file"<<endl;
		return 0;
	}
    
	yyparse();
	
	//print number of lines
	cout<<"Number of lines: "<<lines<<endl;
	
	outlog.close();
	
	fclose(yyin);
	
	return 0;
}