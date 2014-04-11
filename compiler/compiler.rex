class CompilerLanguage
macro
  BLANK			[\ \t]+
  SINGLELINE		\/\/.*
  NUMBER		\d+
  RETURNBLOCK		return
  LEFTBITSHIFT		<<
  RIGHTBITSHIFT		>>
  MINUS			\-
  PLUS			\+
  MULTIPLY		\*
  DIVIDE		\/
  NOTEQUAL		\!=
  EQUALEQUAL		==
  LESSEQUAL		<=
  GREATEREQUAL		>=
  OPENPAREN		\(
  CLOSEPAREN		\)
  OPENCURLY		\{
  CLOSECURLY		\}
  GREATER		>
  LESS			<
  EQUALS		=
  CONST			const
  INT			int
  COMMA			,
  SEMICOLON		;
  NAME			\w(\w|\d)*
  WORD			\w+
  NEWLINE		\n
  TEXT			.

rule
  {BLANK}		# no action
  {SINGLELINE}		# no action
  {NUMBER}		{ p [:NUMBER, text.to_i] }
  {RETURNBLOCK}		{ p [:RETURN, text] }
  {LEFTBITSHIFT}	{ p [:LEFT_BIT_SHIFT, text] }
  {RIGHTBITSHIFT}	{ p [:RIGHT_BIT_SHIFT, text] }
  {MINUS}		{ p [:MINUS, text] }
  {PLUS}		{ p [:PLUS, text] }
  {MULTIPLY}		{ p [:MULTIPLY, text] }
  {DIVIDE}		{ p [:DIVIDE, text] }
  {NOTEQUAL}		{ p [:NOT_EQUALS, text] }
  {EQUALEQUAL}		{ p [:EQUALS_EQUALS, text] }
  {LESSEQUAL}		{ p [:LESS_EQUALS, text] }
  {GREATEREQUAL}	{ p [:GREATER_EQUALS, text] }
  {OPENPAREN}		{ p [:OPEN_PAREN, text] }
  {CLOSEPAREN}		{ p [:CLOSE_PAREN, text] }
  {OPENCURLY}		{ p [:OPEN_CURLY, text] }
  {CLOSECURLY}		{ p [:CLOSE_CURLY, text] }
  {GREATER}		{ p [:GREATER, text] }
  {LESS}		{ p [:LESS, text] }
  {EQUALS}		{ p [:EQUALS, text] }
  {CONST}		{ p [:CONST, text] }
  {INT}			{ p [:INT, text] }
  {COMMA}		{ p [:COMMA, text] }
  {SEMICOLON}		{ p [:SEMICOLON, text] }
  {NAME}		{ p [:NAME, text] }
  {WORD}		{ p [:WORD, text] }
  {NEWLINE}		# no action
  {TEXT}		{ p [:TEXT, text] }

inner
  def tokenize(code)
    scan_setup(code)
    tokens = []
    while token = next_token
      tokens << token
    end
    tokens
  end

end
