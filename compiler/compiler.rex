class CompilerLanguage
macro
  BLANK			[\ \t]+
  SINGLELINE		\/\/.*
  NUMBER		\d+
  RETURNBLOCK		return
  OP		<<|>>|\-|\+|\*|\/|>|<|==|<=|>=|\!=
  OPENPAREN		\(
  CLOSEPAREN		\)
  OPENCURLY		\{
  CLOSECURLY		\}
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
  {BLANK}		{ [false, false]} #no action
  {SINGLELINE}		{ [false, false]} # no action
  {NUMBER}		{ [:NUMBER, text.to_i] }
  {RETURNBLOCK}		{ [:RETURN, text] }
  {OPENPAREN}		{ [:OPEN_PAREN, text] }
  {CLOSEPAREN}		{ [:CLOSE_PAREN, text] }
  {OPENCURLY}		{ [:OPEN_CURLY, text] }
  {CLOSECURLY}		{ [:CLOSE_CURLY, text] }
	{OP} 		{ [:OP, text]}
  {EQUALS}		{ [:EQUALS, text] }
  {CONST}		{ [:CONST, text] }
  {INT}			{ [:INT, text] }
  {COMMA}		{ [:COMMA, text] }
  {SEMICOLON}		{ [:SEMICOLON, text] }
  {NAME}		{ [:NAME, text] }
  {WORD}		{ [:WORD, text] }
  {NEWLINE}		{ [false, false]} # no action
  {TEXT}		{ [:TEXT, text] }

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
