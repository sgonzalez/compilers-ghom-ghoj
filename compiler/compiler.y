class CompilerLanguage
rule
  expression : DIGIT
  | DIGIT ADD DIGIT    { return val[0] + val[2] }
end

---- header
  require './compiler.rex.rb'
 
---- inner
  def parse(input)
    scan_str(input)
  end