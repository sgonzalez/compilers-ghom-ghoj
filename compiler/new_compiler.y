class CompilerLanguage
start stmts
token EQUALS NAME NUMBER CONST INT OP SEMICOLON OPENPAREN CLOSEPAREN OPENBRACE CLOSEBRACE COMMA IF ELSE RETURN
rule
	stmts: stmt stmts {result = StmtsNode.new('stmts', val[0], val[1]) }
			 |						
	stmt: declar    { result = StmtNode.new('stmt', val[0])}
			| expr SEMICOLON {result = StmtNode.new('stmt', val[0])}
			| if    { result = StmtNode.new('stmt', val[0]) }
			| return SEMICOLON {result = StmtNode.new('stmt', val[0])}  
	return: RETURN expr  {result = Return.new('return', val[0])}
	declar: modifier type names EQUALS expr SEMICOLON { result = Declar.new('declar', val[0], val[1], val[2], val[3], val[4])}
				| modifier type names SEMICOLON {result = Declar.new('declar', val[0], val[1], val[2])}
	names: NAME  {result = Names.new('names', val[0])}
			 | NAME COMMA names  {result = Names.new('names', val[0], val[2])}
	modifier: CONST  {result = Modifier.new('modifier', val[0])}
					|
	type: INT   {	result = Type.new('type', val[0])}
	expr: NAME    { result = Expr.new('expr', val[0])}
			| NUMBER   { result = Expr.new('expr', val[0])}
			| subexpr OP expr {result = Expr.new('expr', val[0],val[1],val[2])}
			| subexpr EQUALS expr {result = Expr.new('expr', val[0], val[1], val[2])}
			| OPENPAREN expr CLOSEPAREN   {result = Expr.new('expr', val[0], val[1], val[2])}
	subexpr: NAME  {result = Subexpr.new('subexpr', val[0]) }
				 | NUMBER  {result = Subexpr.new('subexpr', val[0])}
				 | OPENPAREN expr CLOSEPAREN  {result = Subexpr.new('subexpr', val[1])}
	if: IF OPENPAREN expr CLOSEPAREN OPENBRACE stmts CLOSEBRACE {result = Subexpr.new('subexpr', val[0], val[2], val[5])} 
		| IF OPENPAREN expr CLOSEPAREN OPENBRACE stmts CLOSEBRACE ELSE OPENBRACE stmts CLOSEBRACE  {result = Subexpr.new('subexpr', val[0], val[2], val[5], val[7], val[9])}
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
		val.print_addr
		val.print_relations
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
