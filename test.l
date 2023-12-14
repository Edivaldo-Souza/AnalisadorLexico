%{
    #include <iostream>
    using std::cout;
%}

%option noyywrap

delim [ /t/n]
brancos {delim}+
maiusculas [A-z]
letra [{maiusculas}a-z]
digito [0-9]
numero {digito}+

some "SOME"|"some"
value "VALUE"|"value"
all "ALL"|"all"
min "MIN"|"min"
max "MAX"|"max"
exactly "EXACTLY"|"exactly"
that "THAT"|"that"
not "NOT"|"not"
and "AND"|"and"
or "OR"|"or"

stringcomposta  {maiusculas}({letra})+
id           {stringcomposta}("_"?{stringcomposta})*
prop         (\h\a\s{stringcomposta})|(\i\s{stringcomposta}"Of")

%%
[\t\n]+
{some} |        
{value} |      
{all} |     
{min} |        
{max} |       
{exactly} |    
{that} |        
{not} |      
{or} |       
{and}         cout << YYText() << ": palavra chave";
{id} cout << "classe\n";
{prop} cout << "propriedade\n";
{numero}  cout << "numero\n";
%%

int main(){
    yyFlexLexer lexer;
    lexer.yylex();
}
