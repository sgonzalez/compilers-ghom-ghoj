class CompilerLanguage
start stmts
token EQUALS NAME NUMBER CONST INT OP SEMICOLON OPENPAREN CLOSEPAREN OPENBRACE CLOSEBRACE COMMA 
rule
	stmts: stmt stmts {puts val.inspect}
			 |
	stmt: declar    {puts val.inspect}
			| expr SEMICOLON {puts val.inspect}
			| if    {puts val.inspect}
			| assign SEMICOLON  {puts val.inspect}
	declar: modifier type names EQUALS expr SEMICOLON {puts val.inspect}
				| modifier type names SEMICOLON {puts val.inspect}
	names: NAME  {puts val.inspect}
			 | NAME COMMA names  {puts val.inspect}
	modifier: CONST  {puts val.inspect}
					|
	type: INT   {puts val.inspect}
	expr: NAME    {puts val.inspect}
			| NUMBER   {puts val.inspect}
			| subexpr OP expr   {puts val.inspect}
			| OPENPAREN expr CLOSEPAREN   {puts val.inspect}
	subexpr: NAME  {puts val.inspect}
				 | NUMBER  {puts val.inspect}
				 | OPENPAREN expr CLOSEPAREN  {puts val.inspect}
	if: 'if' OPENPAREN expr CLOSEPAREN OPENBRACE stmts CLOSEBRACE {puts val.inspect} 
		| 'if' OPENPAREN expr CLOSEPAREN OPENBRACE stmts CLOSEBRACE 'else' OPENBRACE stmts CLOSEBRACE  {puts val.inspect}
	assign: NAME EQUALS expr   {puts val.inspect}
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

		rescue ParseError => e
			p e
			puts e.backtrace.inspect
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
