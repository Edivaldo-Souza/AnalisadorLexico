%{
    #include <iostream>
    using std::cout;
    enum{SOME,VALUE,ALL,MIN,MAX,EXACTLY,THAT,NOT,AND,OR,ClASSE,PROP,NUM}
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
classe           {stringcomposta}("_"?{stringcomposta})*
prop            ("has"{stringcomposta})|("is"{stringcomposta}"Of")

%%

{brancos}	  ;
{some}        return SOME;
{value}       return VALUE;
{all}         return ALL;
{min}         return MIN;
{max}         return MAX;
{exactly}     return EXACTLY;
{that}        return THAT;
{not}         return NOT;
{or}          return OR;
{and}         return AND;

{prop}        return PROP;
{numero}      return NUM;

%%


