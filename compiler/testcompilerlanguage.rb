require './compiler.rex.rb'

class TestCompilerLanguage
  @evaluator = CompilerScanner.new
  @evaluator.tokenize('// language example 0\n'+\
                      'const int a = 1;\n'+\
                      'int x = 1<<a;\n'+\
                      'int y, z = 3;\n'+\
                      '\n'+\
                      'y = z - x\n'+\
                      'if ( y <= 0) {\n'+\
                      '  z = (x+2) + z*z ;\n'+\
                      '} else {\n'+\
                      '  z = z / y;\n'+\
                      '}\n'+\
                      '\n'+\
                      'return z;\n')
end
