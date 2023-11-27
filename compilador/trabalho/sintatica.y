%{
#include <stdio.h>
#include <stdlib.h>
%}

%token PROGRAM ID SEMICOLON BEGIN END

%%

program:
    PROGRAM ID SEMICOLON block END '.' { printf("Parsed successfully!\n"); }
    ;

block:
    BEGIN statement_part { /* Process block */ }
    ;

statement_part:
    /* Define regras para a parte de declarações de variáveis e partes de comandos */
    ;

%%

int main() {
    yyparse(); // Chama a análise sintática
    return 0;
}

void yyerror(const char *msg) {
    fprintf(stderr, "Erro: %s\n", msg);
    exit(1);
}
