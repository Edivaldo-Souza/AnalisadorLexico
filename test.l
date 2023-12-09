%{
#include <iostream>
using std::cout;
enum {IF, THEN, ELSE, ID, NUM, RELOP};
%}

delim	[ \t\n]
brancos 	{delim}+
letra	[A-Za-z]
digito	[0-9]
id	{letra}({letra}|{digito})*
num	{digito}+(\.{digito}+)?(E[+-]?{digito}+)?

%%
{brancos}		; 
if		return IF;
then		return THEN;
else		return ELSE;
{id}		return ID; 
{num}		return NUM;
"<"		return RELOP;
"<="		return RELOP;
"="		return RELOP;
"<>"		return RELOP;
">"		return RELOP;
">="		return RELOP;
.                  cout << YYText() << " é um token inválido!";
%%

int insertId() {}

int getToken() {}

int main() {
    yyFlexLexer lexer;
    lexer.yylex();
}