%{
#include <stdio.h>
#include <stdlib.h>
%}

%token PROGRAMA_TOKEN VARIAVEL_TOKEN PROCEDIMENTO_TOKEN INICIO_TOKEN FIM_TOKEN
%token INTEIRO_TOKEN REAL_TOKEN BOOLEANO_TOKEN SE_TOKEN ENTAO_TOKEN SENAO_TOKEN
%token ENQUANTO_TOKEN FAZER_TOKEN IDENTIFICADOR_TOKEN PONTO_VIRGULA_TOKEN
%token DOIS_PONTOS_TOKEN VIRGULA_TOKEN ATRIBUICAO_TOKEN PARENTESES_ESQ_TOKEN
%token PARENTESES_DIR_TOKEN MAIS_TOKEN MENOS_TOKEN MULTIPLICACAO_TOKEN
%token DIVISAO_TOKEN IGUAL_TOKEN DIFERENTE_TOKEN MENOR_TOKEN MENOR_IGUAL_TOKEN
%token MAIOR_TOKEN MAIOR_IGUAL_TOKEN E_TOKEN OU_TOKEN NAO_TOKEN
%token FIM_DE_ARQUIVO_TOKEN ERRO_TOKEN

%start programa

%%

programa : PROGRAMA_TOKEN IDENTIFICADOR_TOKEN PONTO_VIRGULA_TOKEN bloco FIM_DE_ARQUIVO_TOKEN
         | PROGRAMA_TOKEN IDENTIFICADOR_TOKEN PONTO_VIRGULA_TOKEN bloco '.' FIM_DE_ARQUIVO_TOKEN
         ;

bloco : parte_declaracoes_variaveis parte_declaracoes_procedimentos comando_composto
      ;

parte_declaracoes_variaveis : '{' VARIAVEL_TOKEN declaracao_variaveis_lista '}' PONTO_VIRGULA_TOKEN
                            ;

declaracao_variaveis_lista : declaracao_variaveis
                           | declaracao_variaveis_lista PONTO_VIRGULA_TOKEN declaracao_variaveis
                           ;

declaracao_variaveis : lista_identificadores DOIS_PONTOS_TOKEN tipo
                     ;

lista_identificadores : IDENTIFICADOR_TOKEN
                      | lista_identificadores VIRGULA_TOKEN IDENTIFICADOR_TOKEN
                      ;

tipo : INTEIRO_TOKEN
     | REAL_TOKEN
     | BOOLEANO_TOKEN
     ;

parte_declaracoes_procedimentos : '{' declaracao_procedimento_lista '}' PONTO_VIRGULA_TOKEN
                                ;

declaracao_procedimento_lista : declaracao_procedimento
                              | declaracao_procedimento_lista PONTO_VIRGULA_TOKEN declaracao_procedimento
                              ;

declaracao_procedimento : PROCEDIMENTO_TOKEN IDENTIFICADOR_TOKEN parametros_formais DOIS_PONTOS_TOKEN bloco
                        ;

parametros_formais : '(' secao_parametros_formais { PONTO_VIRGULA_TOKEN secao_parametros_formais } ')'
                   ;

secao_parametros_formais : IDENTIFICADOR_TOKEN DOIS_PONTOS_TOKEN tipo
                         | VARIAVEL_TOKEN IDENTIFICADOR_TOKEN DOIS_PONTOS_TOKEN tipo
                         ;

comando_composto : INICIO_TOKEN comando { PONTO_VIRGULA_TOKEN comando } FIM_TOKEN
                 ;

comando : atribuicao
        | chamada_procedimento
        | comando_composto
        | comando_condicional1
        | comando_repetitivo1
        ;

atribuicao : IDENTIFICADOR_TOKEN ATRIBUICAO_TOKEN expressao
           ;

chamada_procedimento : IDENTIFICADOR_TOKEN PARENTESES_ESQ_TOKEN lista_expressoes PARENTESES_DIR_TOKEN
                     ;

comando_condicional1 : SE_TOKEN expressao ENTAO_TOKEN comando [ SENAO_TOKEN comando ]
                     ;

comando_repetitivo1 : ENQUANTO_TOKEN expressao FAZER_TOKEN comando
                    ;

expressao : expressao_simples [ relacao expressao_simples ]
          ;

relacao : IGUAL_TOKEN | DIFERENTE_TOKEN | MENOR_TOKEN | MENOR_IGUAL_TOKEN | MAIOR_TOKEN | MAIOR_IGUAL_TOKEN
        ;

expressao_simples : [ MAIS_TOKEN | MENOS_TOKEN ] termo { ( MAIS_TOKEN | MENOS_TOKEN | OU_TOKEN ) termo }
                  ;

termo : fator { ( MULTIPLICACAO_TOKEN | DIVISAO_TOKEN | E_TOKEN ) fator }
      ;

fator : IDENTIFICADOR_TOKEN | NUMERO_TOKEN | PARENTESES_ESQ_TOKEN expressao PARENTESES_DIR_TOKEN | NAO_TOKEN fator
      ;

lista_expressoes : expressao { VIRGULA_TOKEN expressao }
                 ;

%%

int main() {
    // Lógica para ler os tokens e chamar o analisador sintático do Yacc
    yyparse();
    return 0;
}

// Implemente outras funções de apoio, se necessário

int yyerror(const char *msg) {
    fprintf(stderr, "Erro de sintaxe: %s\n", msg);
    return 0;
}
