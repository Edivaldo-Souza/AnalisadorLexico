%{
    #include <iostream>
    using std::cout;
    enum{SOME,VALUE,ALL,MIN,MAX,EXACTLY,THAT,NOT,AND,OR,ClASSE,PROP,NUM}
%}

delim [ /t/n]
brancos {delim}+


%%

{brancos}	  ;
%%


