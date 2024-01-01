#include <iostream>
#include <cstdio>
#include "sl_parser.tab.h"
extern int yyparse();
extern  void yyerror(const char* s);
extern FILE* yyin;

int main() {
    FILE* inputFile = fopen("code.txt", "r");

    if (!inputFile) {
        std::cout << "Error opening input file." << std::endl;
        return 1;
    }

    yyin = inputFile;

    int result = yyparse();

    if (result == 0) {
        std::cout << "Parsing successful." << std::endl;
    } else {
        std::cout << "Parsing failed." << std::endl;
    }

    fclose(inputFile);

    return 0;
}
