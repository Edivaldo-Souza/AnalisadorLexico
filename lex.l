%{
    #include <iostream>
    #include <fstream>
    #include "tokens.h"
    using std::ifstream;
    using std::ofstream;
    using std::cout;
    int numClasses=0,numPalavrasChave=0,numPropriedades=0,numInteiros=0,numIndividuos=0,numTipos=0;
%}

%option noyywrap

delim [ /t/n]
brancos {delim}+
maiusculas [A-Z]
minusculas [a-z]
letra [A-Za-z]
digito [0-9]
numero {digito}+

minusculas_sem_i [abcdefghjklmnopqrstuvxyz]
minusculas_sem_s [abcdefghijklmnopqrtuvxyz]

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

integer "integer"
namespaces ("owl"|"rdfs"|"xsd")":"({letra}+)
tipos ("Class"|"EquivalentTo"|"Individuals"|"SubClassOf"|"DisjointClasses")":"

stringcomposta  {maiusculas}({letra})+
id              {stringcomposta}("_"?{stringcomposta})*
prop            "ssn"|("is"{stringcomposta}*"Of")|({minusculas_sem_i}{minusculas_sem_s}{minusculas}*({stringcomposta})*)
individuo       {id}({numero}+)

%%
[\t\n]+ ;
{some} |        
{value} |      
{all} |     
{min} |        
{max} |       
{exactly} |    
{that} |        
{not} |      
{or} |       
{and}         return KEYWORD;
{id}          return CLASS;
{prop}        return PROP;
{numero}      return NUM;
"["           return SYMBOL;
"]"           return SYMBOL;
"{"           return SYMBOL;
"}"           return SYMBOL;
"("           return SYMBOL;
")"           return SYMBOL;
">"           return SYMBOL;
">="          return SYMBOL;
"<"           return SYMBOL;
"<="          return SYMBOL;
","           return SYMBOL;
\"            return SYMBOL;
{integer}     return TYPE;
{namespaces}  return TYPE;
{tipos}       return KEYWORD;
{individuo}   return INDIVIDUAL;

           
%%

int main(int argc, char** argv ){
    yyFlexLexer lexer;
    ifstream fin;
    ofstream fout("tokens.txt");
    ofstream tabela("tabela.csv");


    if(argc > 1){
        fin.open(argv[1]);
        if(!fin.is_open()){
            cout << "Nao abriu o arquivo";
            exit(EXIT_FAILURE);
        }
        else{
            lexer.switch_streams(&fin);
        }

    }
    int leitor;
    
    tabela << "Categoria do Token,Incidencias\n";
    while((leitor = lexer.yylex())!=0){
        switch(leitor){
            case KEYWORD: 
                fout <<"<KEYWORD,"<<lexer.YYText()<<">\n";
                numPalavrasChave++; 
                break;
            case CLASS:
                fout <<"<CLASS,"<<lexer.YYText()<<">\n";
                numClasses++; 
                break;
            case PROP:
                fout <<"<PROP,"<<lexer.YYText()<<">\n";
                numPropriedades++;
                break;
            case SYMBOL:
                fout <<"<SYMBOL,"<<lexer.YYText()<<">\n"; 
                break;
            case INDIVIDUAL:
                fout <<"<INDIVIDUAL,"<<lexer.YYText()<<">\n";
                numIndividuos++; 
                break;
            case TYPE:
                fout <<"<TYPE,"<<lexer.YYText()<<">\n"; 
                numTipos++;
                break;
            case NUM:
                fout <<"<NUM,"<<lexer.YYText()<<">\n";
                numInteiros++; 
                break;
        }
    }
    tabela << "Palavras reservadas,"<<numPalavrasChave<<"\n";
    tabela << "Classes,"<<numClasses<<"\n";
    tabela << "Propriedades,"<<numPropriedades<<"\n";
    tabela << "Individuos,"<<numIndividuos<<"\n";
    tabela << "Tipos,"<<numTipos<<"\n";
    tabela << "Numeros,"<<numInteiros<<"\n";   

    tabela.close();
    fout.close();
    fin.close();
    return 0;
}
