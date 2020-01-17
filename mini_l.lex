%option noyywrap

%{   
   int currLine = 1, currPos = 1;
%}

DIGIT    [0-9]
   
%%

"function"     {printf("FUNCTION\n"); currPos += yyleng;}
"beginparams"  {printf("BEGIN_PARAMS"); currPos+= yyleng;}
"endparams"    {printf("END_PARAMS"); currPos += yyleng;}
"beginlocals"  {printf("BEGIN_LOCALS"); currPos += yyleng;}
"endlocals"    {printf("END_LOCALS"); currPos += yyleng;}
"beginbody"    {printf("BEGIN_BODY"); currPos += yyleng;}
"endbody"      {printf("END_BODY"); currPos += yyleng;}
"integer"      {printf("INTEGER"); currPos += yyleng;}
"array"        {printf("ARRAY"); currPos += yyleng;}
"of"           {printf("OF"); currPos += yyleng;}
"if"           {printf("IF"); currPos += yyleng;}
"then"         {printf("THEN"); currPos += yyleng;}
"endif"        {printf("ENDIF"); currPos += yyleng;}
"else"         {printf("ELSE"); currPos += yyleng;}
"while"        {printf("WHILE"); currPos += yyleng;}
"do"           {printf("DO"); currPos += yyleng;}
"for"          {printf("FOR"); currPos += yyleng;}
"beginloop"    {printf("BEGINLOOP"); currPos += yyleng;}
"endloop"      {printf("ENDLOOP"); currPos += yyleng;}
"continue"     {printf("CONTINUE"); currPos += yyleng;}
"read"         {printf("READ"); currPos += yyleng;}
"write"        {printf("WRITE"); currPos += yyleng;}

"-"            {printf("SUB\n"); currPos += yyleng;}
"+"            {printf("ADD\n"); currPos += yyleng;}
"*"            {printf("MULT\n"); currPos += yyleng;}
"/"            {printf("DIV\n"); currPos += yyleng;}
"%"            {printf("MOD\n"); currPos += yyleng;}



{DIGIT}+       {printf("NUMBER %s\n", yytext); currPos += yyleng;}

[ \t]+         {/* ignore spaces */ currPos += yyleng;}

"\n"           {currLine++; currPos = 1;}

.              {printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}

%%

int main(int argc, char ** argv)
{
   yylex();
}
