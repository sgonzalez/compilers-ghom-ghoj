class CompilerScanner
rule
  \d+	{ [:DIGIT, text.to_i] }
  \w+	{ [:WORD, text] }
  

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
