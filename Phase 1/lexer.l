%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

FILE *errf;

typedef struct {
    char type[32];
    int count;
} TypeCount;

static TypeCount type_counts[256];
static int type_counts_len = 0;

static int total_tokens = 0;
static int keyword_count = 0;
static int identifier_count = 0;
static int integer_count = 0;
static int float_count = 0;
static int string_count = 0;
static int char_count = 0;
static int operator_count = 0;
static int punctuation_count = 0;
static int other_count = 0;

static void increment_type(const char *type) {
    for (int i = 0; i < type_counts_len; ++i) {
        if (strcmp(type_counts[i].type, type) == 0) {
            type_counts[i].count += 1;
            return;
        }
    }
    if (type_counts_len < 256) {
        strncpy(type_counts[type_counts_len].type, type, sizeof(type_counts[type_counts_len].type) - 1);
        type_counts[type_counts_len].type[sizeof(type_counts[type_counts_len].type) - 1] = '\0';
        type_counts[type_counts_len].count = 1;
        type_counts_len += 1;
    }
}

static void increment_category(const char *category) {
    if (strcmp(category, "Keyword") == 0) {
        keyword_count += 1;
    } else if (strcmp(category, "Identifier") == 0) {
        identifier_count += 1;
    } else if (strcmp(category, "Integer") == 0) {
        integer_count += 1;
    } else if (strcmp(category, "Float") == 0) {
        float_count += 1;
    } else if (strcmp(category, "String") == 0) {
        string_count += 1;
    } else if (strcmp(category, "Char") == 0) {
        char_count += 1;
    } else if (strcmp(category, "Operator") == 0) {
        operator_count += 1;
    } else if (strcmp(category, "Punctuation") == 0) {
        punctuation_count += 1;
    } else {
        other_count += 1;
    }
}

static void emit_token(const char *type, const char *text, const char *category) {
    printf("Line %d: %s → %s\n", yylineno, type, text);
    total_tokens += 1;
    increment_type(type);
    increment_category(category);
}

static void print_summary(void) {
    printf("\nToken Type Counts:\n");
    for (int i = 0; i < type_counts_len; ++i) {
        printf("  %-13s : %d\n", type_counts[i].type, type_counts[i].count);
    }

    printf("\nCategory Counts:\n");
    printf("  Keyword       : %d\n", keyword_count);
    printf("  Identifier    : %d\n", identifier_count);
    printf("  Integer       : %d\n", integer_count);
    printf("  Float         : %d\n", float_count);
    printf("  String        : %d\n", string_count);
    printf("  Char          : %d\n", char_count);
    printf("  Operator      : %d\n", operator_count);
    printf("  Punctuation   : %d\n", punctuation_count);
    printf("  Other         : %d\n", other_count);

    printf("\nTotal Tokens    : %d\n", total_tokens);
}

%}

/* Definitions section */
%option yylineno
DIGIT      [0-9]
ID         [a-zA-Z_][a-zA-Z0-9_]*
INTEGER    [+-]?{DIGIT}+
FLOAT      [+-]?{DIGIT}+\.{DIGIT}+
STRING     \"([^\\\"]|\\.)*\"
CHAR       \'(\\.|[^\\'\n])\'
WS         [ \t\r\n]+

%%

"//".*                    { /* ignore single-line comment */ }


"raqam"                    { emit_token("KW_int", yytext, "Keyword"); }
"aaim"                    { emit_token("KW_float", yytext, "Keyword"); }
"harf"                 { emit_token("KW_char", yytext, "Keyword"); }
"sahih"                   { emit_token("KW_bool", yytext, "Keyword"); }
"laShay"                  { emit_token("KW_void", yytext, "Keyword"); }
"Dalla"                    { emit_token("KW_def / KW_func", yytext, "Keyword"); }
"in"                    { emit_token("KW_if", yytext, "Keyword"); }
"waIn"                { emit_token("KW_elseIf", yytext, "Keyword"); }
"walakin"                   { emit_token("KW_else", yytext, "Keyword"); }
"ikhtiyar"                    { emit_token("KW_switch", yytext, "Keyword"); }
"mithla"                    { emit_token("KW_case", yytext, "Keyword"); }
"daruri"                    { emit_token("KW_default", yytext, "Keyword"); }
"haythuma"                  { emit_token("KW_while", yytext, "Keyword"); }
"bimiqdar"                   { emit_token("KW_for", yytext, "Keyword"); }
"ifal"                 { emit_token("KW_do", yytext, "Keyword"); }
"qaf"                 { emit_token("KW_break", yytext, "Keyword"); }
"istimrar"                 { emit_token("KW_continue", yytext, "Keyword"); }
"raji"                 { emit_token("KW_return", yytext, "Keyword"); }



"=>"                      { emit_token("OP_ASSIGN", yytext, "Operator"); }
"=="                      { emit_token("OP_EQUAL", yytext, "Operator"); }
"<="                      { emit_token("OP_LE", yytext, "Operator"); }
">="                      { emit_token("OP_GE", yytext, "Operator"); }
"<"                       { emit_token("OP_LT", yytext, "Operator"); }
">"                       { emit_token("OP_GT", yytext, "Operator"); }
"+"                      { emit_token("OP_ADD", yytext, "Operator"); }
"-"                      { emit_token("OP_SUBTRACT", yytext, "Operator"); }
"*"                      { emit_token("OP_MUL", yytext, "Operator"); }
"/"                      { emit_token("OP_DEVISION", yytext, "Operator"); }
"++"                      { emit_token("OP_INCREMENT", yytext, "Operator"); }
"--"                      { emit_token("OP_DECREMENT", yytext, "Operator"); }



";"                       { emit_token("P_TERMINATOR", yytext, "Punctuation"); }
"{"                       { emit_token("P_CURLY_START", yytext, "Punctuation"); }
"}"                       { emit_token("P_CURLY_END", yytext, "Punctuation"); }
"~"                       { emit_token("P_TILDE", yytext, "Punctuation"); }
"`"                       { emit_token("P_BACKTICK", yytext, "Punctuation"); }
"@"                       { emit_token("P_AT", yytext, "Punctuation"); }

{STRING}                  { emit_token("STRING", yytext, "String"); }
{CHAR}                    { emit_token("CHAR", yytext, "Char"); }
{FLOAT}                   { emit_token("FLOAT", yytext, "Float"); }
{INTEGER}                 { emit_token("INT", yytext, "Integer"); }
{ID}                      { emit_token("IDENT", yytext, "Identifier"); }

{WS}                      { /* ignore whitespace */ }


.                         { fprintf(errf, "Line %d: ERROR → %s (invalid identifier)\n", yylineno, yytext); }

%%

int yywrap() {
    return 1;
}

int main(int argc, char **argv) {
    /* open error log */
    errf = fopen("error.log", "w");
    if(!errf) { fprintf(stderr, "Cannot open error.log\\n"); exit(1); }

    /* run lexer */
    yylex();

    print_summary();

    fclose(errf);
    return 0;
}
