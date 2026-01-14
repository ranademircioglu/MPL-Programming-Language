%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"

int linenum = 1;
%}

%%


"take"      { return PROGRAM; }
"done"      { return FINISH; }
"here"      { return VAR; }
"num"       { return TYPE_INT; }
"dec"       { return TYPE_FLOAT; }
"cycle"     { return LOOP; }
"while"     { return WHILE; }


"?"         { return IF; }
"!"         { return ELSE; }


"bigger"    { return GT; }     /* ID'den önce */
"lower"     { return LT; }
":="        { return EQ; }
"&"         { return LOGIC_AND; }
"\\"        { return LOGIC_OR; }


"+"         { return PLUS; }
"-"         { return MINUS; }
"*"         { return MULTIPLY; }
"/"         { return DIVIDE; }
"="         { return ASSIGN; }


"^^"        { return SEMICOLON; }
":"         { return COLON; }
"("         { return LPAREN; }
")"         { return RPAREN; }
"begin"     { return LBRACE; }
"end"       { return RBRACE; }


[0-9]+\.[0-9]+        { return FLOAT_NUM; }
[0-9]+                { return INT_NUM; }
[a-zA-Z][a-zA-Z0-9]* { return ID; }


"#".*       ;
[ \t]+      ;
\r          ;
\n          { linenum++; }

.           ;

%%

int yywrap(void)
{
    return 1;
}
