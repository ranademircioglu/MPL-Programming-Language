%{
#include <stdio.h>
#include <stdlib.h>

extern int linenum;
int yylex(void);
void yyerror(const char *s);
%}

/* TOKENS */
%token PROGRAM FINISH
%token VAR TYPE_INT TYPE_FLOAT
%token IF ELSE
%token LOOP WHILE
%token GT LT EQ
%token LOGIC_AND LOGIC_OR

%token PLUS MINUS MULTIPLY DIVIDE
%token ASSIGN
%token SEMICOLON COLON
%token LPAREN RPAREN
%token LBRACE RBRACE

%token ID INT_NUM FLOAT_NUM

/* PRECEDENCE */
%left LOGIC_OR
%left LOGIC_AND
%nonassoc IFX
%nonassoc ELSE
%left GT LT EQ
%left PLUS MINUS
%left MULTIPLY DIVIDE

%%

program
    : PROGRAM LBRACE decl_list stmt_list RBRACE FINISH
      { printf("OK\n"); }
    ;

decl_list
    : decl_list declaration
    | /* empty */
    ;

declaration
    : VAR TYPE_INT COLON id_list SEMICOLON
    | VAR TYPE_FLOAT COLON id_list SEMICOLON
    ;

id_list
    : ID
    | id_list ID
    ;

stmt_list
    : stmt_list statement
    | /* empty */
    ;

statement
    : assignment
    | if_stmt
    | while_stmt
    | compound_stmt
    ;

compound_stmt
    : LBRACE stmt_list RBRACE
    ;

assignment
    : ID ASSIGN expr SEMICOLON
    ;

if_stmt
    : IF LPAREN condition RPAREN statement %prec IFX
    | IF LPAREN condition RPAREN statement ELSE statement
    ;

while_stmt
    : WHILE LPAREN condition RPAREN statement
    | LOOP LPAREN condition RPAREN statement
    ;

condition
    : logical_expr
    ;

logical_expr
    : relational_expr
    | logical_expr LOGIC_AND relational_expr
    | logical_expr LOGIC_OR relational_expr
    ;

relational_expr
    : expr GT expr
    | expr LT expr
    | expr EQ expr
    ;

expr
    : expr PLUS expr
    | expr MINUS expr
    | expr MULTIPLY expr
    | expr DIVIDE expr
    | LPAREN expr RPAREN
    | ID
    | INT_NUM
    | FLOAT_NUM
    ;

%%

void yyerror(const char *s)
{
    fprintf(stderr, "Syntax Error on line %d\n", linenum);
}

int main(void)
{
    yyparse();
    return 0;
}

