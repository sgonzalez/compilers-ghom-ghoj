class CompilerLanguage
macro
  BLANK			[\ \t]+
  SINGLELINE		//.*
  NUMBER		\d+
  RETURNBLOCK		return
  LEFTBITSHIFT		<<
  RIGHTBITSHIFT		>>
  MINUS			-
  PLUS			+
  MULTIPLY		\*
  DIVIDE		/
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
  {NUMBER}		{ [:NUMBER, text.to_i] }
  {RETURNBLOCK}		{ [:RETURN, text] }
  {LEFTBITSHIFT}	{ [:LEFT_BIT_SHIFT, text] }
  {RIGHTBITSHIFT}	{ [:RIGHT_BIT_SHIFT, text] }
  {MINUS}		{ [:MINUS, text] }
  {PLUS}		{ [:PLUS, text] }
  {MULTIPLY}		{ [:MULTIPLY, text] }
  {DIVIDE}		{ [:DIVIDE, text] }
  {NOTEQUAL}		{ [:NOT_EQUALS, text] } 
  {EQUALEQUAL}		{ [:EQUALS_EQUALS, text] }
  {LESSEQUAL}		{ [:LESS_EQUALS, text] }
  {GREATEREQUAL}	{ [:GREATER_EQUALS, text] }
  {OPENPAREN}		{ [:OPEN_PAREN, text] }
  {CLOSEPAREN}		{ [:CLOSE_PAREN, text] }
  {OPENCURLY}		{ [:OPEN_CURLY, text] }
  {CLOSECURLY}		{ [:CLOSE_CURLY, text] }
  {GREATER}		{ [:GREATER, text] }
  {LESS}		{ [:LESS, text] } 
  {EQUALS}		{ [:EQUALS, text] }
  {CONST}		{ [:CONST, text] }
  {INT}			{ [:INT, text] }
  {COMMA}		{ [:COMMA, text] }
  {SEMICOLON}		{ [:SEMICOLON, text] }  
  {NAME}		{ [:NAME, text] }
  {WORD}		{ [:WORD, text] }
  {NEWLINE}		# no action
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
