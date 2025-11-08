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
static int number_count = 0;
static int string_count = 0;
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
    } else if (strcmp(category, "Number") == 0) {
        number_count += 1;
    } else if (strcmp(category, "String") == 0) {
        string_count += 1;
    } else if (strcmp(category, "Operator") == 0) {
        operator_count += 1;
    } else if (strcmp(category, "Punctuation") == 0) {
        punctuation_count += 1;
    } else {
        other_count += 1;
    }
}

static void emit_token(const char *type, const char *text, const char *category) {
    printf("%-15s : %s\n", type, text);
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
    printf("  Number        : %d\n", number_count);
    printf("  String        : %d\n", string_count);
    printf("  Operator      : %d\n", operator_count);
    printf("  Punctuation   : %d\n", punctuation_count);
    printf("  Other         : %d\n", other_count);

    printf("\nTotal Tokens    : %d\n", total_tokens);
}

%}

/* Definitions section */
DIGIT      [0-9]
ID         [a-zA-Z_][a-zA-Z0-9_]*
NUMBER     {DIGIT}+(\.{DIGIT}+)?
STRING     \"([^\\\"]|\\.)*\"
WS         [ \t\r\n]+

%%

"//".*                    { /* ignore single-line comment */ }


"noor"                    { emit_token("KW_NOOR", yytext, "Keyword"); }
"iqra"                    { emit_token("KW_IQRA", yytext, "Keyword"); }
"zawiyah"                 { emit_token("KW_ZAWIYAH", yytext, "Keyword"); }
"kitab"                   { emit_token("KW_KITAB", yytext, "Keyword"); }
"akhbar"                  { emit_token("KW_AKHBAR", yytext, "Keyword"); }
"func"                    { emit_token("KW_FUNC", yytext, "Keyword"); }
"varn"                    { emit_token("KW_VARN", yytext, "Keyword"); }
"muthanna"                { emit_token("KW_MUTHANNA", yytext, "Keyword"); }
"watan"                   { emit_token("KW_WATAN", yytext, "Keyword"); }
"sala"                    { emit_token("KW_SALA", yytext, "Keyword"); }
"show"                    { emit_token("KW_SHOW", yytext, "Keyword"); }
"when"                    { emit_token("KW_WHEN", yytext, "Keyword"); }
"repeat"                  { emit_token("KW_REPEAT", yytext, "Keyword"); }
"until"                   { emit_token("KW_UNTIL", yytext, "Keyword"); }
"returnn"                 { emit_token("KW_RETURNN", yytext, "Keyword"); }

":="                      { emit_token("OP_ASSIGN", yytext, "Operator"); }
"->"                      { emit_token("OP_ARROW", yytext, "Operator"); }
"**"                      { emit_token("OP_POWER", yytext, "Operator"); }
"%%"                      { emit_token("OP_PERC", yytext, "Operator"); }

"~"                       { emit_token("P_TILDE", yytext, "Punctuation"); }
"`"                       { emit_token("P_BACKTICK", yytext, "Punctuation"); }
"@"                       { emit_token("P_AT", yytext, "Punctuation"); }

{STRING}                  { emit_token("STRING", yytext, "String"); }
{NUMBER}                  { emit_token("NUMBER", yytext, "Number"); }
{ID}                      { emit_token("IDENT", yytext, "Identifier"); }

{WS}                      { /* ignore whitespace */ }


.                         { fprintf(errf, "LEX_ERROR: Unknown char '%s' at line (approx) --\\n", yytext); }

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
