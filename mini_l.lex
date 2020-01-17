%option noyywrap

%{   
   int currLine = 1, currPos = 1;
%}

DIGIT    [0-9]
   
%%

"and"          {printf("AND\n"); currPos += yyleng;}
"or"           {printf("OR\n"); currPos += yyleng;}
"not"          {printf("NOT\n"); currPos += yyleng;}
"true"         {printf("TRUE\n"); currPos += yyleng;}
"false"        {printf("FALSE\n"); currPos += yyleng;}
"return"       {printf("RETURN\n"); currPos += yyleng;}

"-"            {printf("MINUS\n"); currPos += yyleng;}
"+"            {printf("PLUS\n"); currPos += yyleng;}
"*"            {printf("MULT\n"); currPos += yyleng;}
"/"            {printf("DIV\n"); currPos += yyleng;}

"=="	       {printf("EQ\n"); currPos += yyleng;}
"<>"           {printf("NEQ\n"); currPos += yyleng;}
"<"            {printf("LT\n"); currPos += yyleng;}
">"            {printf("GT\n"); currPos += yyleng;}
"<="           {printf("LTE\n"); currPos += yyleng;}
">="           {printf("GTE\n"); currPos += yyleng;}

";"	       {printf("SEMICOLON\n"); currPos += yyleng;}
":"	       {printf("COLON\n"); currPos += yyleng;}
","            {printf("COMMA\n"); currPos += yyleng;}
"("	       {printf("L_PAREN\n"); currPos += yyleng;}
")"            {printf("R_PAREN\n"); currPos += yyleng;}
"["            {printf("L_SQUARE_BRACKET\n"); currPos += yyleng;}
"]"            {printf("R_SQUARE_BRACKET\n"); currPos += yyleng;}
":="           {printf("ASSIGN\n"); currPos += yyleng;}
{DIGIT}+       {printf("NUMBER %s\n", yytext); currPos += yyleng;}

[ \t]+         {/* ignore spaces */ currPos += yyleng;}

"\n"           {currLine++; currPos = 1;}

.              {printf("Error at line %d, column %d: unrecognized symbol \"%s\"\n", currLine, currPos, yytext); exit(0);}

%%

int main(int argc, char ** argv)
{
   yylex();
}
