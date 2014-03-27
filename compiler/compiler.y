class CompilerLanguage
rule
  expression : DIGIT
  | DIGIT ADD DIGIT    { return val[0] + val[2] }
end