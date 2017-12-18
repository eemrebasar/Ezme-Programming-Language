%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char*  s);
%}
%token IDENTIFIER
%token CONST
%token EQUAL
%token LCB
%token RCB
%token BRACKETS
%token IMPLIES
%token OR
%token NOT
%token AND
%token TRUE
%token FALSE
%token COMMA
%token IFANDONLYIF
%token EQUALS
%token IF
%token WHILE
%token ELSE
%token COMMENTBEGINS
%token COMMENTFINISH
%token NL
%token COMMENT
%token FINISH
%token LOGICALASSIGN
%token OUTPUT
%token INPUT
%token MESSAGE
%token NEWLINE
%token SPACE
%token MAIN
%token NUMBER
%left OR NOT IMPLIES IFANDONLYIF AND EQUALS
%%
lines: /* Nothing */
|lines line
;
line:start
;
start: MAIN LCB statements RCB
;
statements: statementMore
;
statementMore: statement
|statementMore statement
;
statement: assign
|ifElse
|predicate
|while
|commentbegins
|predicatecall
|createlist
|message
;
predicate: IDENTIFIER BRACKETS list BRACKETS LCB statementMore OUTPUT logicalexp RCB
;
predicatecall: IDENTIFIER BRACKETS list BRACKETS
;
assign: IDENTIFIER EQUAL TRUE
|IDENTIFIER EQUAL FALSE
|IDENTIFIER EQUAL NOT logicalexp
|IDENTIFIER EQUAL LOGICALASSIGN logicalexp
|IDENTIFIER EQUAL predicatecall
|IDENTIFIER EQUAL CONST
|IDENTIFIER EQUAL input
|listelement EQUAL LOGICALASSIGN logicalexp
|listelement EQUAL TRUE
|listelement EQUAL FALSE
|CONST EQUAL FALSE
|CONST EQUAL TRUE
|CONST EQUAL LOGICALASSIGN logicalexp
|CONST EQUAL predicatecall
|CONST EQUAL NOT logicalexp
;
ifElse: IF BRACKETS logicalexp BRACKETS LCB statementMore RCB
|IF BRACKETS logicalexp BRACKETS LCB statementMore RCB ELSE LCB statementMore RCB
;
while: WHILE BRACKETS logicalexp BRACKETS LCB statementMore RCB
;
input: INPUT FALSE
|INPUT TRUE
;
logicvalue: TRUE
|FALSE
;
type: IDENTIFIER
|CONST
|logicvalue
|listelement
;
listelement: IDENTIFIER LCB NUMBER RCB
;
list: type
| list COMMA type
;
createlist: IDENTIFIER LCB list RCB
;
message: MESSAGE logicalexp
;
logicalexp: ifandonlyifexp EQUALS logicalexp
|ifandonlyifexp
;
ifandonlyifexp: impliesexp IFANDONLYIF ifandonlyifexp
|impliesexp
;
impliesexp: orexp IMPLIES impliesexp
|orexp
;
orexp: andexp OR orexp
|andexp
;
andexp: exp AND andexp
|exp
;
exp:type
|BRACKETS logicalexp BRACKETS
;
commentbegins: COMMENTBEGINS statements COMMENTFINISH
;
%%
#include "lex.yy.c"
int lineno = 1;
int check = 1;
void yyerror(char* s){fprintf(stdout,"%s on line %d\n",s,lineno);
  check = 0;}
int main(void){
  yyparse();
  if(check == 1){
    printf("Input program accepted\n"); }
 return 0;
}
