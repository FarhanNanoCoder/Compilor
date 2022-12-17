char [a-zA-Z]
digit [0-9]
special [$_@]
space " "
newline "\n"
Datatype "int_f"|"double_f"|"float_f"|"char_f"|"string_f"
Operator "add"|"sub"|"multi"|"div"|"mod"|"power"
Relational_Operator "greater_than"|"less_than"|"equal_to"|"not_equal_to"|"greater_than_eq"|"less_than_eq"
single_line_comment "//".*
multiple_line_comment [/][*][A-Za-z0-9. \n]*[*][/]
variable "var_"[a-zA-Z]([a-zA-Z0-9])*
logical_operator "&&"|"||"|"!!"

%{
	#include<stdio.h>
	#include "main.tab.h"
	#include <string.h>
	#include <math.h>
%}

%% 
","		{return COMMA;}
";"		{return SEMICOLON;}
":"		{return COLON;}
"show_var" { return SHOW_VAR;}
"show_str" {return SHOW_STR;}
"show_line" {return SHOW_LINE;}
"scan" {return SCAN;}

{digit}+ 	{
				yylval.val = atoi(yytext);
				return NUM;
			}

 
{single_line_comment} {
	printf("This is a single line comment\n");
}
{multiple_line_comment} {
	printf("This is a multiple line comment\n");
}


"main_f"		{return MAIN;}
"func_"({char}|{digit}|{special})+ {return FUNCTION;}
{variable} { strcpy(yylval.text,yytext);return ID;}


"int_f"			{ return INT;}
"double_f"		{return DOUBLE;}
"float_f"		{return FLOAT;}
"char_f"		{return CHAR;}

"if_f"			{ return IF;}
"else_f"		{return ELSE;}
"again_if_f"	{return ELSEIF;}
"switch_f"		{return SWITCH;}
"default_f"		{return DEFAULT;}


"fbs"		{ return FBS; }
"fbe"		{ return FBE; }
"sbs"		{ return SBS; }
"sbe"		{ return SBE; }


"for_loop"		{return FOR;}
"To"			{return TO;}
"inc_by"		{return INCREMENT_BY;}
"while" 		{return WHILE;}


"greater_than"		{return GT;}
"less_than"		{return LT;}
"greater_than_eq"		{return GE;}
"less_than_eq"		{return LE;}
"not_equal_to"		{return NE;}
"equal_to"		{return EQ;}
"Less"  {return LESS;}
"Great" {return GREAT;}


"assign_f"		{return ASGN;} 

"add"		{return PLUS;}
"sub"		{return MINUS;}
"multi"		{return MUL;}
"div"		{return DIV;}
"mod"		{return MODULUS;}
"power"		{return POWER;}


. {}
"\""(.)*"\"" {strcpy(yylval.text,yytext);return STR;}

%%

int yywrap()
{
	return 1;
}

int main(){
   yyin = freopen("input.txt","r",stdin);
   yyout = freopen("output.txt","w",stdout);
   yyparse();
}