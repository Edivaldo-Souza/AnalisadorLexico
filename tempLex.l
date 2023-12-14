%{
    #include <iostream>
    using std::cout;
    enum{SOME,VALUE,ALL,MIN,MAX,EXACTLY,THAT,NOT,AND,OR,ID,PROP,NUM}
%}

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
prop            ("has"{stringcomposta})|("is"{stringcomposta}"Of")

%%

{brancos}	  ;
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
{id}          cout << YYText() << ": classe";
{prop}        cout << YYText() << ": propriedade";
{numero}      cout << YYText() << ": inteiro";

%%


