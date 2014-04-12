class CompilerLanguage
macro
  BLANK			[\ \t]+
  SINGLELINE		\/\/.*
	IF 				if
	ELSE			else
  NUMBER		\d+
  RETURNBLOCK		return
  OP		<<|>>|\-|\+|\*|\/|>|<|\=\=|<\=|>\=|\!\=
  OPENPAREN		[(]
  CLOSEPAREN		[)]
  OPENBRACE		[{]
  CLOSEBRACE		[}]
  EQUALS		[=]
  CONST			const
  INT			int
  COMMA		[,]
  SEMICOLON		[;]
  NAME			\w(\w|\d)*
  WORD			\w+
  NEWLINE		[\n]
  TEXT			.

rule
  {BLANK}		{} #no action
  {SINGLELINE}		{} # no action
  {NUMBER}		{ [:NUMBER, text.to_i] }
	{IF}			{ [:IF, text]}
	{ELSE}		{ [:ELSE, text]}
  {RETURNBLOCK}		{ [:RETURN, text] }
  {OPENPAREN}		{ [:OPENPAREN, text] }
  {CLOSEPAREN}		{ [:CLOSEPAREN, text] }
  {OPENBRACE}		{ [:OPENBRACE, text] }
  {CLOSEBRACE}		{ [:CLOSEBRACE, text] }
	{OP} 		{ [:OP, text]}
  {EQUALS}		{ [:EQUALS, text] }
  {CONST}		{ [:CONST, text] }
  {INT}			{ [:INT, text] }
  {COMMA}		{ [:COMMA, text] }
  {SEMICOLON}		{ [:SEMICOLON, text] }
  {NAME}		{ [:NAME, text] }
  {WORD}		{ [:WORD, text] }
  {NEWLINE}		{} # no action
  {TEXT}		{ [:TEXT, text] }

end
