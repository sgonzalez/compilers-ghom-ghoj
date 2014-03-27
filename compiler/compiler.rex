class CompilerScanner
macro
  BLANK     [\ \t]+

rule
  BLANK         # no action
  \d+           { [:digit, text.to_i] }
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
