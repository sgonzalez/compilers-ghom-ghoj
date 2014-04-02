class CompilerLanguage
rule
  start: stmts  #{ return ast }
  stmts: stmt stmts #{ stmt.adopt_children(stmts) }
       | ''
  stmt: decl SEMICOLON #{ decl }
      | NAME EQUALS expr SEMICOLON
      | RETURN NAME SEMICOLON
      | ifblock
  decl: modifier type NAME EQUALS EXPR
      | modifier type NAME
  modifier: CONST
          | ''
  ifblock: if elsif else
  if: IF OPEN_PAREN expr CLOSE_PAREN OPEN_CURLY stmts CLOSE_CURLY
  elsif: ELSE if elsif
       | ''
  else: ELSE OPEN_PAREN expr CLOSE_PAREN OPEN_CURLY stmts CLOSE_CURLY
      | ''
  type: INT
  infix: NOT_EQUALS | EQUALS_EQUALS | LESS_EQUALS | GREATER_EQUALS | GREATER | LESS | PLUS | MINUS | MULTIPLY | DIVIDE | RIGHT_BIT_SHIFT | LEFT_BIT_SHIFT
  expr: NAME
      | NUMBER
      | expr infix expr
      | OPEN_PAREN expr CLOSE_PAREN
end

---- header
  require './compiler.rex.rb'
 
---- inner
  def parse(input)
    scan_str(input)
  end