%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* External variables from lexer */
extern int yylex();
extern int line_num; 
extern char *yytext;
extern FILE *yyin;

/* Error handling function */
void yyerror(const char *s);

/* Success flag */
int parse_success = 1;
%}

/* Token declarations - matching Phase 1 scanner */

/* Keywords */
%token KW_int KW_float KW_char KW_bool KW_void KW_func
%token KW_if KW_elseIf KW_else KW_switch KW_case KW_default
%token KW_while KW_for KW_do KW_break KW_continue KW_return
%token KW_output KW_input

/* Operators */
%token OP_ASSIGN OP_EQUAL OP_LE OP_GE OP_LT OP_GT
%token OP_ADD OP_SUBTRACT OP_MUL OP_DEVISION
%token OP_INCREMENT OP_DECREMENT

/* Punctuation */
%token P_TERMINATOR P_CURLY_START P_CURLY_END P_TILDE
%token P_BACKTICK P_AT

/* Literals and Identifiers */
%token IDENT INT FLOAT CHAR STRING

/* Define operator precedence (lowest to highest) */
%left OP_ADD OP_SUBTRACT
%left OP_MUL OP_DEVISION
%left OP_EQUAL OP_LE OP_GE OP_LT OP_GT

%%

/* ============================================
   GRAMMAR RULES
   ============================================ */

/* Program Structure */
program
    : function_def
        { printf("   ✓ Program structure validated\n"); }
    ;

function_def
    : KW_func IDENT P_TILDE block
        { printf("   ✓ Main function (Dalla) parsed successfully\n"); }
    ;

block
    : P_CURLY_START statement_list P_CURLY_END
    ;

statement_list
    : statement statement_list
    | /* empty */
    ;

/* Statement Types */
statement
    : variable_declaration
    | assignment_statement
    | if_statement
    | for_loop
    | while_loop
    | output_statement
    | input_statement
    | return_statement
    | break_statement
    | continue_statement
    | error P_TERMINATOR
        { yyerrok; parse_success = 0; }
    ;

/* Variable Declarations */
variable_declaration
    : type IDENT OP_ASSIGN expression P_TERMINATOR
        { printf("   ✓ Variable declaration with initialization parsed\n"); }
    | type IDENT P_TERMINATOR
        { printf("   ✓ Variable declaration parsed\n"); }
    ;

/* Type Definitions */
type
    : KW_int      { /* int */ }
    | KW_float    { /* float */ }
    | KW_char     { /* char */ }
    | KW_bool     { /* bool */ }
    ;

/* Assignment Statement */
assignment_statement
    : IDENT OP_ASSIGN expression P_TERMINATOR
        { printf("   ✓ Assignment statement parsed\n"); }
    ;

/* If Statement (in) */
if_statement
    : KW_if expression P_TILDE block else_if_part else_part
        { printf("   ✓ Conditional statement (in) parsed\n"); }
    ;

else_if_part
    : KW_elseIf expression P_TILDE block else_if_part
    | /* empty */
    ;

else_part
    : KW_else P_TILDE block
    | /* empty */
    ;

/* While Loop (haythuma) */
while_loop
    : KW_while expression P_TILDE block
        { printf("   ✓ While loop (haythuma) parsed\n"); }
    | KW_while P_TILDE block
        { printf("   ✓ While loop (haythuma) parsed\n"); }
    ;

/* For Loop (bimiqdar) */
for_loop
    : KW_for IDENT OP_ASSIGN expression P_TILDE block
        { printf("   ✓ For loop (bimiqdar) parsed\n"); }
    ;

/* Output Statement (kharij) */
output_statement
    : KW_output expression P_TERMINATOR
        { printf("   ✓ Output statement (kharij) parsed\n"); }
    ;

/* Input Statement (dakhil) */
input_statement
    : KW_input IDENT P_TERMINATOR
        { printf("   ✓ Input statement (dakhil) parsed\n"); }
    ;

/* Return Statement (raji) */
return_statement
    : KW_return expression P_TERMINATOR
        { printf("   ✓ Return statement (raji) parsed\n"); }
    | KW_return P_TERMINATOR
        { printf("   ✓ Return statement (raji) parsed\n"); }
    ;

/* Break Statement (qaf) */
break_statement
    : KW_break P_TERMINATOR
        { printf("   ✓ Break statement (qaf) parsed\n"); }
    ;

/* Continue Statement (istimrar) */
continue_statement
    : KW_continue P_TERMINATOR
        { printf("   ✓ Continue statement (istimrar) parsed\n"); }
    ;

/* Expression Grammar (handles operator precedence) */
expression
    : expression OP_EQUAL expression
    | expression OP_LE expression
    | expression OP_GE expression
    | expression OP_LT expression
    | expression OP_GT expression
    | expression OP_ADD term
    | expression OP_SUBTRACT term
    | term
    ;

term
    : term OP_MUL factor
    | term OP_DEVISION factor
    | factor
    ;

factor
    : IDENT
    | INT
    | FLOAT
    | CHAR
    | STRING
    | IDENT OP_INCREMENT
    | IDENT OP_DECREMENT
    ;

%%


void yyerror(const char *s) {
    fprintf(stderr, "\n");
    fprintf(stderr, "╔════════════════════════════════════════════════════════╗\n");
    fprintf(stderr, "║              SYNTAX ERROR DETECTED                     ║\n");
    fprintf(stderr, "╚════════════════════════════════════════════════════════╝\n");
    fprintf(stderr, "  Line Number:    %d\n", line_num);
    fprintf(stderr, "  Error Type:     %s\n", s);
    fprintf(stderr, "  Found Token:    '%s'\n", yytext);
    fprintf(stderr, "════════════════════════════════════════════════════════\n\n");
    parse_success = 0;
}

int main(int argc, char **argv) {
    printf("\n");
    printf("╔════════════════════════════════════════════════════════╗\n");
    printf("║         Syntax Analyzer Phase 2                        ║\n");
    printf("║         Parsing                                        ║\n");
    printf("╚════════════════════════════════════════════════════════╝\n\n");

    if (argc < 2) {
        printf("Usage: %s <input_file.an>\n", argv[0]);
        printf("Example: %s valid_program.an\n\n", argv[0]);
        return 1;
    }

    FILE *input_file = fopen(argv[1], "r");
    if (!input_file) {
        fprintf(stderr, "Error: Cannot open file '%s'\n", argv[1]);
        return 1;
    }

    printf("Parsing file: %s\n", argv[1]);
    printf("════════════════════════════════════════════════════════\n\n");

    yyin = input_file;
    
    int result = yyparse();
    
    fclose(input_file);

    printf("\n════════════════════════════════════════════════════════\n");
    
    if (result == 0 && parse_success) {
        printf("╔════════════════════════════════════════════════════════╗\n");
        printf("║         Syntax analysis successful                     ║\n");
        printf("║         No syntax errors detected.                     ║\n");
        printf("╚════════════════════════════════════════════════════════╝\n");
    } else {
        printf("╔════════════════════════════════════════════════════════╗\n");
        printf("║         Syntax analysis failed                         ║\n");
        printf("║         Please fix the errors above.                   ║\n");
        printf("╚════════════════════════════════════════════════════════╝\n");
    }
    printf("\n");

    return (result == 0 && parse_success) ? 0 : 1;
}
