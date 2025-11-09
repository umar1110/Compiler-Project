## Phase 1 Requirements

Important Submission & Evaluation Instructions (Read Carefully)
Each student must work individually any identical keywords, regex, code, or outputs will result in ZERO marks.
You must design your own 15 keywords, 3–5 operators, and 2–4 punctuations (self-created or imaginative not copied from book/internet).

You must create your own (Language) Mini C++ test program (minimum 20 lines) not copied from any classmate, ChatGPT, or internet.

Submission Requirements
Submit GitHub repository link only (not zip file).
Repository must contain:
  • Lex/scanner.l file
  • Your unique sample test program
  • tokens.txt output file
  • error log (if errors exist)
Also upload PDF documentation with regex table, FA diagrams & explanation.
Sample execution video (max 5 mins) must be in the GitHub repo.

VERY IMPORTANT RULES (Marks will be deducted if ignored)
If GitHub link is not submitted → automatic deduction.
If originality is not visible → project will be rejected.
You must include at least ONE sample input & output (tokenization result) before submission to prove that your scanner works.
Your keywords, operators & punctuations must clearly appear in your test program and in the output.

Final Note
Your project must look self-created, imaginative, and unique.
Anyone caught sharing or duplicating content will face strict marking penalties / rejection.

---

## Project Overview

- **Custom tokens**: `lexer.l` now defines 15 bespoke keywords (`raqam`, `aaim`, `harf`, `sahih`, `laShay`, `Dalla`, `in`, `waIn`, `walakin`, `ikhtiyar`, `mithla`, `daruri`, `haythuma`, `bimiqdar`, `qaf`, `istimrar`, `raji`), 7 operators (`=>`, `+`, `-`, `*`, `/`, `++`, `--`), and 5 punctuations (`;`, `{`, `}`, `~`, `` ` ``). Each token is reported via `emit_token`, logging both the stream and category counts.
- **Token summary**: Execution prints compact rows (`TYPE : value`) followed by per-token, per-category, and total counts so the output stays short and verifiable.
- **Unique sample program**: `alnoor_test.an` contains a 22-line mini program written with the new vocabulary. It exercises every keyword, operator, and punctuation rule at least once.
- **Sample outputs**: Running `./lexer < alnoor_test.an > tokens.txt` captures the structured token list and summary. Any unrecognized characters land in `error.log`.
- **Build & regenerate steps**:
  1. `flex lexer.l`
  2. `gcc lex.yy.c -o lexer`
  3. Edit `alnoor_test.an` with your sample program
  4. `./lexer < alnoor_test.an > tokens.txt`
  5. Inspect `error.log` for `UNKNOWN_TOKEN` rows (one per bad character).
- **Documentation assets**:
  - `lexer.l` – primary scanner definition.
  - `alnoor_test.an` – required sample program.
  - `tokens.txt` – token listing and summary (submission artifact).
  - `error.log` – records unknown characters when they occur.
  - `lexer` – compiled scanner executable (rebuild as above when sources change).

## Deliverables Checklist

- [X] Custom keyword/operator/punctuation set (15 / 7 / 5 respectively).
- [X] Original 20+ line sample program using all custom tokens.
- [X] Generated token output with totals saved to repository.
- [X] Error log ready to capture lexical issues.
- [X] PDF documentation (regex table, FA diagrams, explanation). ( Incomplete pdf as completed in hardcopy)
- [X] Execution video (≤5 minutes) to be added before final submission. Loom link: https://www.loom.com/share/c4333cd9d3064d7aa3314bee6df05b07
