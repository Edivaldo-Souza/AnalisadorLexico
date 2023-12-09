%{
#include <iostream>
using std::cout;
enum{SOME,VALUE,ALL,MIN,MAX,EXACTLY,THAT,NOT,AND,OR}
%}

delim [ /t/n]
brancos {delim}+
maiusculas [A-z]
letra [{maiusculas}a-z]
digito [0-9]
numero {digito}+

some "SOME"|"some"
value "VALUE"|"value"

stringcomposta  {maiusculas}({letra})+
classe          {stringcomposta}(_?{stringcomposta})*
propriedade     ("has"{stringcomposta})|("is"{stringcomposta}"Of")

%%

{brancos}	;
SOME        return SOME;
VALUE       return VALUE;
ALL         return ALL;
min         return MIN;
max         return MAX;
EXACTLY     return EXACTLY;
THAT        return THAT;
not         return not;
OR          return OR;
AND         return AND;

%%


