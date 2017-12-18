%{
#include <stdlib.h>
void yyerror(char *);                                                                                                      
%}
digit [0-9]
char [a-zA-Z_$]
type ({variable}|{const}|{boolean})
not (!)
logicalexp (({type}" "{logicalsigns}" "{type})|{type}|({not}{type})|({type}" "{logicalsigns}" "({not}{type}))|(({not}{type})" "{logicalsigns}" "{type})|(({not}{type}" "{logicalsigns}" "({not}{type})))
assign (({variable}" "{equalOp}" "{logicalexp}))
boolean ({true}|{false})
const ({lcb}{name})
true ('true')
false ('false')
variable ({digit}+|{name})
name ({char}+|({char}+{digit}+))
logicalsigns ({implies}|{and}|{ifandif}|{or}|{equals})
implies (->)
and (&)
ifandif (<=>)
or (^)
equals (==)
equalOp (=)
main ('main')
whilename ('while')
elsename ('else')
statement ({assign})
statementMore ({statement}+)
typeMore (({type}{comma})++)
comma (,)
brac (^^)
lcb (<<)
finishline (;)                                                                                                                                                        
rcb (>>)
commentbegin (<<<)
commentfinish (>>>)
comment ('')
logicalassign ('logicalassign')
output ('output')
input ('input')
message ('message')
function ({name}" "{brac}" "{typeMore}" "{brac}" "{lcb}" "{statementMore}" "{output}" "{type}" "{rcb})
while ({whilename}" "{brac}" "{logicalexp}" "{brac}" "{lcb}" "{statementMore}" "{rcb})
ifelse (({ifname}" "{brac}" "{logicalexp}" "{brac}" "{lcb}" "{statementMore}" "{rcb})|({ifname}" "{brac}" "{logicalexp}" "{brac}" "{lcb}" "{statementMore}" "{rcb}" "elsename}" "{lcb}" "{statementMore}" "{rcb}))
ifname ('if')
connectives ({logicalsigns}|!)
%option yylineno
%%
{char}{variable}* return IDENTIFIER;                                                                                                                                   
{digit}* return NUMBER;                                                                                                                                                
{equalOp} return EQUAL;                                                                                                                                                
{lcb} return LCB;                                                                                                                                                      
{rcb} return RCB;                                                                                                                                                      
{brac} return BRACKETS;                                                                                                                                                
{implies} return IMPLIES;                                                                                                                                              
{or} return OR;                                                                                                                                                        
{not} return NOT;                                                                                                                                                      
{and} return AND;                                                                                                                                                      
{comma} return COMMA;                                                                                                                                                  
{ifandif} return IFANDONLYIF;
{equals} return EQUALS;                                                                                                                                                
{ifname} return IF;                                                                                                                                                    
{whilename} return WHILE;                                                                                                                                              
{main} return MAIN;                                                                                                                                                    
{logicalassign} return LOGICALASSIGN;                                                                                                                                  
{elsename} return ELSE;                                                                                                                                                
{commentbegin} return COMMENTBEGINS;                                                                                                                                   
{commentfinish} return COMMENTFINISH;                                                                                                                                  
{comment} return COMMENT;                                                                                                                                              
{finishline} return FINISH;                                                                                                                                            
{output} return OUTPUT;                                                                                                                                                
{input} return INPUT;                                                                                                                                                  
{message} return MESSAGE;                                                                                                                                              
{true} return TRUE;                                                                                                                                                    
{false} return FALSE;                                                                                                                                                  
[\n] {extern int lineno; lineno++;}
[ \t]+ ;                                                                                                                                                 
 . ;  
{const} return CONST;                                                                                                                                                  
%%
int yywrap(void){
return 1;  
}