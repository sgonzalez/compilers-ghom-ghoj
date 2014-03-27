#!/usr/bin/ruby

require './compiler.rex.rb'
require './compiler.tab.rb'

class Compiler
  @scanner = CompilerScanner.new
  while true
    input = STDIN.gets
    puts input
    @scanner.tokenize(input)
  end
end