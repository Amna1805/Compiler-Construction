%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char* s);

%}
%union {
    int number;
    char* identifier;
}

%token <number> NUMBER
%token <identifier> IDENTIFIER
%token PLUS MINUS TIMES DIVIDE MOD AND OR LT GT LEQ GEQ EQ NEQ NOT

%token PROGRAM FUNCTION PARAMLIST PARAMREST BLOCK STATEMENT BREAK CALL ARGLIST ARGREST IF ELSE LET READ RETURN WHILE WRITE

%%

program: PROGRAM function_list block

function_list: /* empty */ | function_list function

function: FUNCTION IDENTIFIER '(' param_list ')' block

param_list: IDENTIFIER param_rest | /* empty */

param_rest: ',' IDENTIFIER param_rest | /* empty */

block: '{' statement_list '}'

statement_list: /* empty */ | statement_list statement

statement: BREAK ';' | CALL IDENTIFIER '(' arg_list ')' ';' | IF EXPR block else_part | LET IDENTIFIER '=' EXPR ';' | READ IDENTIFIER ';' | RETURN EXPR ';' | WHILE EXPR block | WRITE EXPR ';'

else_part: ELSE block | /* empty */

arg_list: EXPR arg_rest | /* empty */

arg_rest: ',' EXPR arg_rest | /* empty */

EXPR: NUMBER | IDENTIFIER | '(' EXPR ')' | '(' UNOP EXPR ')' | '(' BINOP EXPR EXPR ')'
BINOP: PLUS | MINUS | TIMES | DIVIDE | MOD | AND | OR | LT | GT | LEQ | GEQ | EQ | NEQ
UNOP: NOT | '~'


%%

void yyerror(const char* s) {
    fprintf(stderr, "Parser error is occuring: %s\n", s);
    exit(1);
}

