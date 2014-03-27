class CompilerLanguage
macro
  BLANK     [\ \t]+

rule
  BLANK         # no action
  //.*		# no action
  \d+           { [:NUMBER, text.to_i] }
  return	{ [:RETURN, text] }
  <<		{ [:LEFT_BIT_SHIFT, text] }
  >>		{ [:RIGHT_BIT_SHIFT, text] }
  -		{ [:MINUS, text] }
  +		{ [:PLUS, text] }
  \*		{ [:MULTIPLY, text] }
  /		{ [:DIVIDE, text] }
  \!=		{ [:NOT_EQUALS, text] } 
  ==		{ [:EQUALS_EQUALS, text] }
  <=		{ [:LESS_EQUALS, text] }
  >=		{ [:GREATER_EQUALS, text] }
  \(		{ [:OPEN_PAREN, text] }
  \)		{ [:CLOSE_PAREN, text] }
  \{		{ [:OPEN_CURLY, text] }
  \}		{ [:CLOSE_CURLY, text] }
 
  >		{ [:GREATER, text] }
  <		{ [:LESS, text] } 
  =		{ [:EQUALS, text] }
  const		{ [:CONST, text] }
  int		{ [:INT, text] }
  ,		{ [:COMMA, text] }
  ;		{ [:SEMICOLON, text] }  
  \w(\w|\d)*	{ [:NAME, text] }
  \w+           { [:WORD, text] }
  \n
  .             { [:TEXT, text] }
  
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
