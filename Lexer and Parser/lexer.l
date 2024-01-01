%{
#include "sl_parser.tab.h"
%}

%%

[ \t\n]          /* Ignore whitespace */
"PROGRAM"       { return PROGRAM; }
"FUNCTION"      { return FUNCTION; }
"PARAMLIST"     { return PARAMLIST; }
"PARAMREST"     { return PARAMREST; }
"BLOCK"         { return BLOCK; }
"STATEMENT"     { return STATEMENT; }
"BREAK"         { return BREAK; }
"CALL"          { return CALL; }
"ARGLIST"       { return ARGLIST; }
"ARGREST"       { return ARGREST; }
"IF"            { return IF; }
"ELSE"          { return ELSE; }
"LET"           { return LET; }
"READ"          { return READ; }
"RETURN"        { return RETURN; }
"WHILE"         { return WHILE; }
"WRITE"         { return WRITE; }
[0-9]+          { yylval.number = atoi(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]*  { yylval.identifier = strdup(yytext); return IDENTIFIER; }
"+"             { return PLUS ;}
"-"             { return MINUS; }
"*"             { return TIMES; }
"/"             { return DIVIDE; }
"%"             { return MOD; }
"<"             { return LT; }
">"             { return GT; }
"<="            { return LEQ; }
">="            { return GEQ; }
"=="            { return EQ; }
"!="            { return NEQ; }
"&"             { return AND; }
"|"             { return OR; }
"~"             { return NEQ; }
"!"             { return NOT; }
"="             { return EQ; }
","             { return ','; }
"("             { return '('; }
")"             { return ')'; }
"{"             { return '{'; }
"}"             { return '}'; }
";"             { return ';'; }

.               { fprintf(stderr, "Unexpected character: %s\n", yytext); exit(1); }

%%

int yywrap() {
    return 1;
}
