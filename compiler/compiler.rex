class CompilerLanguage
macro
  BLANK     [\ \t]+

rule
  BLANK         # no action
  \d+           { [:digit, text.to_i] }
  const		{ [:const, text] }
  int		{ [:int, text] }
  ,		{ [:comma, text] }
  
  \w+           { [:word, text] }
  \n
  .             { [text, text] }
  
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
