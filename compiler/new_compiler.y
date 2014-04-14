class CompilerLanguage
start stmts
token EQUALS NAME NUMBER CONST INT OP SEMICOLON OPENPAREN CLOSEPAREN OPENBRACE CLOSEBRACE COMMA IF ELSE RETURN
rule
	stmts: stmt stmts {puts "stmts"
										puts val.inspect}
			 |
	stmt: declar    { puts "stmt"
										puts val.inspect}
			| expr SEMICOLON {puts "stmt"
												puts val.inspect}
			| if    { puts "stmt"
								puts val.inspect}
			#| assign SEMICOLON  { puts "stmt"
			#											puts val.inspect}
			| return SEMICOLON
	
	return: RETURN expr
	declar: modifier type names EQUALS expr SEMICOLON { puts "declar"
																											puts val.inspect}
				| modifier type names SEMICOLON { puts "declar"
																					puts val.inspect}
	names: NAME  {puts "names"
								puts val.inspect}
			 | NAME COMMA names  {puts "names"
			 											puts val.inspect}
	modifier: CONST  {puts "modifier"
										puts val.inspect}
					|
	type: INT   {	puts "type"
								puts val.inspect}
	expr: NAME    { puts "expr"
									puts val.inspect}
			| NUMBER   {puts "expr"
									puts val.inspect}
			| subexpr OP expr {puts "expr"
												 puts val.inspect}
			| subexpr EQUALS expr
			#| NAME OP expr  {puts val.inspect}
			#| NUMBER OP expr  {puts val.inspect} 
			| OPENPAREN expr CLOSEPAREN   {puts "expr"
																			puts val.inspect}
	subexpr: NAME  {puts "subexpr" 
									puts val.inspect}
				 | NUMBER  {puts "subexpr"
				 						puts val.inspect}
				 | OPENPAREN expr CLOSEPAREN  {puts "subexpr"
				 																puts val.inspect}
	if: IF OPENPAREN expr CLOSEPAREN OPENBRACE stmts CLOSEBRACE {puts "if"
																																puts val.inspect} 
		| IF OPENPAREN expr CLOSEPAREN OPENBRACE stmts CLOSEBRACE ELSE OPENBRACE stmts CLOSEBRACE  {puts "if"
																																																puts val.inspect}
	#assign: NAME EQUALS expr   {puts "assign"
	#														puts val.inspect}
end

---- header
	require './compiler.rex.rb'
	require './reflectivevisitor.rb'

	$ast = AbstractNode.new(:root)

---- inner

	

---- footer ----

	parser = CompilerLanguage.new
	begin
		val = parser.scan_str( $stdin.read)
		p val

		#rescue ParseError => e
		#	p e
	#		puts e.backtrace.inspect
	end


=begin
		parser = CompilerLanguage.new
		count = 0
		scnt  = 0

		puts 'type "ctrl-d" to quit.'

    string_to_parse = ""
		while true do
			# puts
			# print '> '
      instr = gets
      break if !instr
      string_to_parse << instr
			#break if !str# == ?\C-d#/q/i === str
		end

    begin
      val = parser.parse( string_to_parse )
      p $ast
      # print '= ', val, "\n"
    rescue ParseError
      puts $!
    rescue
      puts 'unexpected error ?!'
      raise
=end
	#end
