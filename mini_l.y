%{
#define YY_NO_UNPUT
#include <stdio.h>
#include <stdlib.h>
void yyerror(const char* s);
%}

%union{
  char* ident_val;
  int num_val;
 }

%error-verbose
%start Program

%token <ident_val> IDENT
%token <num_val> NUMBER

%token FUNCTION
%token BEGIN_PARAMS
%token END_PARAMS
%token BEGIN_LOCALS
%token END_LOCALS
%token BEGIN_BODY
%token END_BODY
%token COLON
%token ARRAY
%token L_SQUARE_BRACKET
%token R_SQUARE_BRACKET
%token OF
%token INTEGER
%token SEMICOLON
%token COMMA
%token IF
%token THEN
%token ELSE
%token ENDIF
%token WHILE
%token BEGINLOOP
%token ENDLOOP
%token DO
%token FOR
%token READ
%token WRITE
%token CONTINUE
%token RETURN
%token TRUE
%token FALSE
%token L_PAREN
%token R_PAREN
%left EQ
%left OR
%left AND
%left GT 
%left LT
%left NEQ
%left LTE
%left GTE
%left ADD
%left SUB
%left MULT
%left DIV
%left MOD
%left ASSIGN
%right NOT


%% /* Begin Grammars! */

Program:	
	Function Program {
		printf("Program -> Function Program\n");
	} | 

	%empty { 
		printf("Program -> epsilon\n");
	}
;

Function:
	FUNCTION Ident SEMICOLON BEGIN_PARAMS FunctionDec END_PARAMS BEGIN_LOCALS FunctionDec END_LOCALS BEGIN_BODY MultipleStatements END_BODY {
		printf("Function -> FUNCTION Ident SEMICOLON BEGIN_PARAMS FunctionDec END_PARAMS BEGIN_LOCALS FunctionDec END_LOCALS BEGIN_BODY MultipleStatements END_BODY\n");
	} 
;

Declaration: 
	Identifier COLON INTEGER {
		printf("Declaration -> Identifier COLON INTEGER\n");
	} | 

	Identifier COLON ARRAY L_SQUARE_BRACKET NUMBER R_SQUARE_BRACKET OF INTEGER {
		printf("Declaration -> Identifier COLON ARRAY L_SQUARE_BRACKET NUMBER %d R_SQUARE_BRACKET OF INTEGER\n", $5);
	}
;
			
FunctionDec:
	Declaration SEMICOLON FunctionDec{
		printf("FunctionDec -> Declaration SEMICOLON FunctionDec\n");
	} |

	%empty {
		printf("FunctionDec -> epsilon\n");
	}
;

Identifier:
	Ident COMMA Identifier{
		printf("Identifier -> Ident COMMA Identifier\n");
	} |

	Ident {
		printf("Identifier -> Ident\n");
	}
;

Statement:
	Var ASSIGN Expression { 
		printf("Statement -> Var ASSIGN Expression\n");
	} |

	IF Bool-Expr THEN MultipleStatements ENDIF {
		printf("Statement -> IF Bool-Expr THEN MultipleStatements ENDIF\n");
	} |

	IF Bool-Expr THEN MultipleStatements ELSE MultipleStatements ENDIF {
		printf("Statement -> IF Bool-Expr THEN MultipleStatements ELSE MultipleStatements ENDIF\n");
	} |

	WHILE Bool-Expr BEGINLOOP MultipleStatements ENDLOOP {
		printf("Statement -> WHILE Bool-Expr BEGINLOOP MultipleStatements ENDLOOP\n");
	} |

	DO BEGINLOOP MultipleStatements ENDLOOP WHILE Bool-Expr {
		printf("Statement -> DO BEGINLOOP MultipleStatements ENDLOOP WHILE Bool-Expr\n");
	} |

	FOR Var ASSIGN NUMBER SEMICOLON Bool-Expr SEMICOLON Var ASSIGN Expression BEGINLOOP MultipleStatements ENDLOOP{
		printf("Statement -> FOR Var EQ NUMBER SEMICOLON Bool-Expr SEMICOLON Var EQ Expression BEGINLOOP MultipleStatements ENDLOOP\n");
	} |

	READ MultVar {
		printf("Statement -> READ MultVar\n");
	} |

	WRITE MultVar {
		printf("Statement -> WRITE MultVar\n");
	} |

	CONTINUE {
		printf("Statement -> CONTINUE\n");
	} |

	RETURN Expression {
		printf("Statement -> RETURN Expression\n");
	}
;

MultipleStatements:
	Statement SEMICOLON MultipleStatements {
		printf("MultipleStatements -> Statement SEMICOLON MultipleStatements\n");
	} |

	Statement SEMICOLON {
		printf("MultipleStatements -> Statement SEMICOLON\n");
	}
;



Var:
	Ident {
		printf("Var -> Ident\n");
	} |

	Ident L_SQUARE_BRACKET Expression R_SQUARE_BRACKET {
		printf("Var -> Ident L_SQUARE_BRACKET Expression R_SQUARE_BRACKET\n");
	}
;

MultVar:
	Var {
		printf("MultVar -> Var\n");
	} |

	Var COMMA MultVar {
		printf("MultVar -> Var COMMA MultVar\n");
	}
;

Expression:
	Multiplicative-Expr {
		printf("Expression -> Multiplicative-Expr\n");
	} |

	Multiplicative-Expr ADD Expression {
		printf("Expression -> Multiplicative-Expr ADD Expression\n");
	} |

	Multiplicative-Expr SUB Expression {
		printf("Expression -> Multiplicative-Expr SUB Expression\n");
	} 
;

Expressions:
	Expression COMMA Expressions {
		printf("Expressions -> Expression COMMA Expressions\n");
	} |

	Expression {
		printf("Expressions -> Expression\n");
	} |

	%empty {
		printf("Expressions -> epsilon\n");
	}
;

Multiplicative-Expr:
	Term {
		printf("Multiplicative-Expr -> Term\n");
	} |

	Term MULT Multiplicative-Expr {
		printf("Multiplicative-Expr -> Term MULT Multiplicative-Expr\n");
	} | 

	Term DIV Multiplicative-Expr {
		printf("Multiplicative-Expr -> Term DIV Multiplicative-Expr\n");
	} | 

	Term MOD Multiplicative-Expr {
		printf("Multiplicative-Expr -> Term MOD Multiplicative-Expr\n");
	}
;

Term:
	Var {
		printf("Term -> Var\n");
	} |

	SUB Var {
		printf("Term -> SUB Var\n");
	} |

	NUMBER {
		printf("Term -> NUMBER %d \n", $1);
	} |

	SUB NUMBER {
		printf("Term -> SUB NUMBER %d \n", $2);
	} |

	L_PAREN Expression R_PAREN {
		printf("Term -> L_PAREN Expression R_PAREN\n");
	} |

	SUB L_PAREN Expression R_PAREN {
		printf("Term -> SUB L_PAREN Expression R_PAREN\n");
	} |

	Ident L_PAREN Expressions R_PAREN {
		printf("Term -> Ident L_PAREN Expressions R_PAREN\n");
	}
;

Bool-Expr:
	Relation-And-Expr {
		printf("Bool-Expr -> Relation-And-Expr\n");
	} |

	Bool-Expr OR Relation-And-Expr{
		printf("Bool-Expr -> Bool-Expr OR Relation-And-Expr\n");
	}
;

Relation-And-Expr:
	Relation-Expr {
		printf("Relation-And-Expr -> Relation-Expr\n");
	} |

	Relation-Expr AND Relation-And-Expr {
		printf("Relation-And-Expr -> Relation-Expr AND Relation-And-Expr\n");
	}
;

Relation-Expr:
	NOT Relation-Expression {
		printf("Relation-Expr -> NOT Relation-Expression\n");
	} |

	Relation-Expression {
		printf("Relation-Expr -> Relation-Expression\n");
	}
;

Relation-Expression:
	Expression Comp Expression{
		printf("Relation-Expression -> Expression Comp Expression\n");
	} |

	TRUE {
		printf("Relation-Expression -> TRUE\n");
	} |

	FALSE {
		printf("Relation-Expression -> FALSE\n");
	} |

	L_PAREN Bool-Expr R_PAREN {
		printf("Relation-Expression -> L_PAREN Bool-Expr R_PAREN\n");
	}
;

Comp:
	EQ {
		printf("Comp -> EQ\n");
	} |

	LT {
		printf("Comp -> LT\n");
	} | 

	GT {
		printf("Comp -> GT\n");
	} |

	NEQ {
		printf("Comp -> NEQ\n");
	} |

	LTE {
		printf("Comp -> LTE\n");
	} |

	GTE {
		printf("Comp -> GTE\n");
	} 
;

Ident:
	IDENT{
		printf("Ident -> IDENT %s \n", $1);
	}

%%

void yyerror(const char* s) {
  extern int currLine;
  extern char* yytext;

  printf("ERROR: %s at symbol \"%s\" on line %d\n", s, yytext, currLine);
  exit(1);
}










