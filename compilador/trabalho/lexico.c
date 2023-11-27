%{
#include <stdio.h>
#include <stdlib.h>
%}

/* Regra de traduçao */
/* Definiçao das expressoes regulares*/

delim [\t\n]      ; /* Ignorar espaços em branco */
ws {delim}+
letras [A-Za-z]
digitos [0-9]
id {letras} ({letras}: {digitos})*
numero {digito} + ( \. {digito } + )?

%%

/* Procedimentos auciliares */
/*  Tokens */
{ws}         {/* nenhuma ação e nenhum valor retornado */}

"program"    { return PROGRAM; }      /* Token para "program" */
";"          { return SEMICOLON; }    /* Token para ";" */
"var"        { return VAR; }          /* Token para "var" */
"integer"    { return INTEGER; }      /* Token para "integer" */
"real"       { return REAL; }         /* Token para "real" */
"boolean"    { return BOOLEAN; }      /* Token para "boolean" */
"begin"      { return BEGIN; }        /* Token para "begin" */
"end"        { return END; }          /* Token para "end" */
":="         { return ATRIBUIR; }     /* Token para ":=" */
{id}         { return ID; }           /* Token para identificadores */
"+"          { return SOMA; }         /* Token para "+" */
"-"          { return SUBTRACAO; }    /* Token para "-" */
"*"          { return MULTIPLICACAO; }/* Token para "*" */
"/"          { return DIVISAO; }      /* Token para "/" */
"="          { return IGUAL; }        /* Token para "=" */
"<>"         { return DIFERENTE; }    /* Token para "<>" */
"<"          { return MENOR; }        /* Token para "<" */
"<="         { return MENOR_IGUAL; }  /* Token para "<=" */
">"          { return MAIOR; }        /* Token para ">" */
">="         { return MAIOR_IGUAL; }  /* Token para ">=" */
"or"         { return OR; }           /* Token para "or" */
"and"        { return AND; }          /* Token para "and" */
"not"        { return NOT; }          /* Token para "not" */
","          { return VIRGULA; }      /* Token para "," */
"("          { return ABRE_PARENTESES; } /* Token para "(" */
")"          { return FECHA_PARENTESES; } /* Token para ")" */
"."          { return PONTO; }        /* Token para "." */
/*analize de necesidade*/
{digito}+ {
    yylval.ival = atoi(yytext); // Converte yytext para inteiro e armazena em yylval
    return INTEGER_TOKEN; // Retorna o token correspondente a um número inteiro
}

{digito}+"."{digito}+ {
    yylval.fval = atof(yytext); // Converte yytext para float e armazena em yylval
    return FLOAT_TOKEN; // Retorna o token correspondente a um número de ponto flutuante
}

%%