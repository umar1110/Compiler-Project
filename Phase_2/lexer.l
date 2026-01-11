%{
#include <stdio.h>
#include "y.tab.h"

int line_num = 1;
extern FILE *yyin;
%}

%option noyywrap

DIGIT      [0-9]
ID         [a-zA-Z_][a-zA-Z0-9_]*
INTEGER    [+-]?{DIGIT}+
FLOAT      [+-]?{DIGIT}+\.{DIGIT}+
STRING     \"([^\\\"]|\\.)*\"
CHAR       \'(\\.|[^\\'\n])\'
WS         [ \t\r]+
NEWLINE    \n

%%

{WS}                        { }
{NEWLINE}                   { line_num++; }
"//".*                      { }

"raqam"                     { return KW_int; }
"aaim"                      { return KW_float; }
"harf"                      { return KW_char; }
"sahih"                     { return KW_bool; }
"laShay"                    { return KW_void; }
"Dalla"                     { return KW_func; }
"in"                        { return KW_if; }
"waIn"                      { return KW_elseIf; }
"walakin"                   { return KW_else; }
"ikhtiyar"                  { return KW_switch; }
"mithla"                    { return KW_case; }
"daruri"                    { return KW_default; }
"haythuma"                  { return KW_while; }
"bimiqdar"                  { return KW_for; }
"ifal"                      { return KW_do; }
"qaf"                       { return KW_break; }
"istimrar"                  { return KW_continue; }
"raji"                      { return KW_return; }
"kharij"                    { return KW_output; }
"dakhil"                    { return KW_input; }

"=>"                        { return OP_ASSIGN; }
"=="                        { return OP_EQUAL; }
"<="                        { return OP_LE; }
">="                        { return OP_GE; }
"<"                         { return OP_LT; }
">"                         { return OP_GT; }
"+"                         { return OP_ADD; }
"-"                         { return OP_SUBTRACT; }
"*"                         { return OP_MUL; }
"/"                         { return OP_DEVISION; }
"++"                        { return OP_INCREMENT; }
"--"                        { return OP_DECREMENT; }

";"                         { return P_TERMINATOR; }
"{"                         { return P_CURLY_START; }
"}"                         { return P_CURLY_END; }
"~"                         { return P_TILDE; }
"`"                         { return P_BACKTICK; }
"@"                         { return P_AT; }

{STRING}                    { return STRING; }
{CHAR}                      { return CHAR; }
{FLOAT}                     { return FLOAT; }
{INTEGER}                   { return INT; }
{ID}                        { return IDENT; }

.                           { fprintf(stderr, "Lexical Error at line %d: Invalid token '%s'\n", line_num, yytext); }

%%
