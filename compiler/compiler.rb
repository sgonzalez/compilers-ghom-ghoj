#!/usr/bin/ruby

require './compiler.rex.rb'

class Compiler
  @scanner = CompilerScanner.new
  while true
    input = $stdin.read
    puts input
    @scanner.tokenize(input)
  end
end