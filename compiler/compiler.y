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
      | subexpr infix expr
      | OPEN_PAREN expr CLOSE_PAREN
  subexpr: NAME
         | NUMBER
         | OPEN_PAREN expr CLOSE_PAREN
end

---- header
  require './compiler.rex.rb'

---- inner
  def parse(input)
    scan_str(input)
  end

  def on_error(error_token_id, error_value, value_stack)
		token_name = token_to_str(error_token_id)
		token_name.downcase!
		token = error_value.to_s.inspect

		str = 'parse error on '
		str << token_name << ' ' unless token_name == token
		str << token
	end


---- footer ----

		parser = CompilerLanguage.new
		count = 0
		scnt  = 0

		puts
		puts 'type "ctrl-d" to quit.'
		puts

		while true do
			# puts
			# print '> '
      instr = gets
      break if !instr
			str = instr.chomp!
			#break if !str# == ?\C-d#/q/i === str
			begin
				val = parser.parse( str )
				# print '= ', val, "\n"
			rescue ParseError
				puts $!
			rescue
				puts 'unexpected error ?!'
				raise
		end

	end
