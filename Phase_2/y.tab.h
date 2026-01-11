/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     KW_int = 258,
     KW_float = 259,
     KW_char = 260,
     KW_bool = 261,
     KW_void = 262,
     KW_func = 263,
     KW_if = 264,
     KW_elseIf = 265,
     KW_else = 266,
     KW_switch = 267,
     KW_case = 268,
     KW_default = 269,
     KW_while = 270,
     KW_for = 271,
     KW_do = 272,
     KW_break = 273,
     KW_continue = 274,
     KW_return = 275,
     KW_output = 276,
     KW_input = 277,
     OP_ASSIGN = 278,
     OP_EQUAL = 279,
     OP_LE = 280,
     OP_GE = 281,
     OP_LT = 282,
     OP_GT = 283,
     OP_ADD = 284,
     OP_SUBTRACT = 285,
     OP_MUL = 286,
     OP_DEVISION = 287,
     OP_INCREMENT = 288,
     OP_DECREMENT = 289,
     P_TERMINATOR = 290,
     P_CURLY_START = 291,
     P_CURLY_END = 292,
     P_TILDE = 293,
     P_BACKTICK = 294,
     P_AT = 295,
     IDENT = 296,
     INT = 297,
     FLOAT = 298,
     CHAR = 299,
     STRING = 300
   };
#endif
/* Tokens.  */
#define KW_int 258
#define KW_float 259
#define KW_char 260
#define KW_bool 261
#define KW_void 262
#define KW_func 263
#define KW_if 264
#define KW_elseIf 265
#define KW_else 266
#define KW_switch 267
#define KW_case 268
#define KW_default 269
#define KW_while 270
#define KW_for 271
#define KW_do 272
#define KW_break 273
#define KW_continue 274
#define KW_return 275
#define KW_output 276
#define KW_input 277
#define OP_ASSIGN 278
#define OP_EQUAL 279
#define OP_LE 280
#define OP_GE 281
#define OP_LT 282
#define OP_GT 283
#define OP_ADD 284
#define OP_SUBTRACT 285
#define OP_MUL 286
#define OP_DEVISION 287
#define OP_INCREMENT 288
#define OP_DECREMENT 289
#define P_TERMINATOR 290
#define P_CURLY_START 291
#define P_CURLY_END 292
#define P_TILDE 293
#define P_BACKTICK 294
#define P_AT 295
#define IDENT 296
#define INT 297
#define FLOAT 298
#define CHAR 299
#define STRING 300




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

