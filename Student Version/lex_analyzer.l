%option noyywrap

%{
#include<bits/stdc++.h>
#include "symbol_info.h"
using namespace std;

ofstream yyoutlog; //output filestream for log file

string loglist = ""; //list of tokens along with line numbers

// define necessary c++ variables and functions here (if any)
int lines = 1;

%}

/* Regular Definitions */

delim	 [ \t\v\r]

/* write regular expressions for whitespace and newline */
ws [ \t]		 

newline	 [\n]  

letter_	 [A-Za-z_]
digit	 [0-9]

/* write regular expressions for id, float and integers */
id [a-zA-Z_][a-zA-Z0-9_]*
int [+-]?[0-9]+  //according to the manual,  + or - will not be the part of an integer.
float [+-]?([0-9]*[.][0-9]+|[0-9]+[.][0-9]*)




%%

{ws}		{ /* ignore whitespace */ }

{newline}	{ 
            /* do necessary bookkeeping (line number tracking etc.) */ 
            lines++;
            }

{id}       {
                symbol_info *s = new symbol_info((string)yytext,"ID");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <ID> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return ID;
            }

{int}       {
                symbol_info *s = new symbol_info((string)yytext,"CONST_INT");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <CONST_INT> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return CONST_INT;
            }

{float}     {
                symbol_info *s = new symbol_info((string)yytext,"CONST_FLOAT");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <CONST_FLOAT> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return CONST_FLOAT;
            }



"if"        { 
                loglist="Line no "+to_string(lines)+": Token <IF> Lexeme "+yytext+" found"+"\n"+"\n";
			    yyoutlog<<loglist;
                return IF; 
            }

"else"      { 
                loglist="Line no "+to_string(lines)+": Token <ELSE> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return ELSE;
            }

"while"     { 
                loglist="Line no "+to_string(lines)+": Token <WHILE> Lexeme "+yytext+" found"+"\n"+"\n";
			    yyoutlog<<loglist; 
                return WHILE; 
            }

"for"       { 
                loglist="Line no "+to_string(lines)+": Token <FOR> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return FOR;
            }

"do"        { 
                loglist="Line no "+to_string(lines)+": Token <DO> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return DO; 
            }

"break"     { 
                loglist="Line no "+to_string(lines)+": Token <BREAK> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return BREAK; 
            }

"int"       { 
                loglist="Line no "+to_string(lines)+": Token <INT> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return INT; 
            }

"char"      { 
                loglist="Line no "+to_string(lines)+": Token <CHAR> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return CHAR; 
            }

"float"     { 
                loglist="Line no "+to_string(lines)+": Token <FLOAT> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return FLOAT; 
            }

"double"    { 
                loglist="Line no "+to_string(lines)+": Token <DOUBLE> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return DOUBLE; 
            }

"void"      { 
                loglist="Line no "+to_string(lines)+": Token <VOID> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return VOID; 
            }

"return"    { 
                loglist="Line no "+to_string(lines)+": Token <RETURN> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return RETURN; 
            }

"switch"    { 
                loglist="Line no "+to_string(lines)+": Token <SWITCH> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return SWITCH; 
            }

"case"      { 
                loglist="Line no "+to_string(lines)+": Token <CASE> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return CASE; 
            }

"default"   { 
                loglist="Line no "+to_string(lines)+": Token <DEFAULT> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return DEFAULT; 
            }

"continue"  { 
                loglist="Line no "+to_string(lines)+": Token <CONTINUE> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return CONTINUE; 
            }

"goto"      { 
                loglist="Line no "+to_string(lines)+": Token <GOTO> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return GOTO; 
            }

"printf"    { 
                loglist="Line no "+to_string(lines)+": Token <PRINTF> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return PRINTF; 
            }






"+"|"-"	    {
                symbol_info *s = new symbol_info((string)yytext,"ADDOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <ADDOP> Lexeme "+yytext+" found"+"\n"+"\n";
			    yyoutlog<<loglist;
                return ADDOP;
		    }

"*"|"/"|"%" {            
                symbol_info *s = new symbol_info((string)yytext,"MULOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <MULOP> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return MULOP;
            }

"++"|"--"   { 
                symbol_info *s = new symbol_info((string)yytext,"INCOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <INCOP> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return INCOP;
            }

"="         { 
                symbol_info *s = new symbol_info((string)yytext,"ASSIGNOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <ASSIGNOP> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist; 
                return ASSIGNOP;
            }
/* ASSIGNOP defined before RELOP to avoid ambiguity
otherwise, "=" will be matched as RELOP. */

"<"|">"|"=="|"<="|">="|"!=" { 
                symbol_info *s = new symbol_info((string)yytext,"RELOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <RELOP> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return RELOP;
            }



"&&"|"||"   { 
                symbol_info *s = new symbol_info((string)yytext,"LOGICOP");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <LOGICOP> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return LOGICOP;
            }

"!"         { 
                symbol_info *s = new symbol_info((string)yytext,"NOT");
                yylval = (YYSTYPE)s;
                loglist="Line no "+to_string(lines)+": Token <NOT> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return NOT;
            }

"("         { 
                loglist="Line no "+to_string(lines)+": Token <LPAREN> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return LPAREN;
            }

")"         { 
                loglist="Line no "+to_string(lines)+": Token <RPAREN> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return RPAREN;
            }

"{"         { 
                loglist="Line no "+to_string(lines)+": Token <LCURL> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return LCURL;
            }

"}"         { 
                loglist="Line no "+to_string(lines)+": Token <RCURL> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return RCURL;
            }

"["         { 
                loglist="Line no "+to_string(lines)+": Token <LTHIRD> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return LTHIRD;
            }

"]"         { 
                loglist="Line no "+to_string(lines)+": Token <RTHIRD> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return RTHIRD;
            }

","         { 
                loglist="Line no "+to_string(lines)+": Token <COMMA> Lexeme "+yytext+" found"+"\n"+"\n";
			    yyoutlog<<loglist;               
                return COMMA; 
            }

":"         { 
                loglist="Line no "+to_string(lines)+": Token <COLON> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return COLON;
            }

";"         { 
                loglist="Line no "+to_string(lines)+": Token <SEMICOLON> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return SEMICOLON;
            }

/*Unrecognized token*/
.           { 
                loglist="Line no "+to_string(lines)+": Token <UNRECOGNIZED> Lexeme "+yytext+" found"+"\n"+"\n";
                yyoutlog<<loglist;
                return UNRECOGNIZED;
            }

%%





