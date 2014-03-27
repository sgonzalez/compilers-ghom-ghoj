class CompilerLanguage
macro
  BLANK     [\ \t]+

rule
  BLANK         # no action
  //
  \d+           { [:NUMBER, text.to_i] }
  const		{ [:CONST, text] }
  int		{ [:INT, text] }
  ,		{ [:COMMA, text] }
  ;		{ [:SEMICOLON, text] }  
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
