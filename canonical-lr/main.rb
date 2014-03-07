#!/usr/bin/ruby

#### Santiago Gonzalez, Jeremy Kerr, Brianna Fidder, Benjamin Fuller, Paulo Iza

# note: an item format is ["S", "aBCd$", 0]

$productions = {}
root_nonterminal = ""
grammar_symbols = []


def is_terminal x
  (x == x.downcase)
end


def is_nonterminal x
  (x == x.upcase) and !x.include?('$')
end

def closure items
  k = items
  items.each do |item|
    if item[1][item[2]] and is_nonterminal(item[1][item[2]])
      $productions[item[1][item[2]]].each do |rule|
        k << [item[1][item[2]], rule.gsub(/lambda/, ''), 0]
      end
    end
  end
  return k
end  


def goto items, x
  tprime = []
  items.each do |item|
    if item[1][item[2]] == x
      tprime << [item[0], item[1], item[2]+1]
    end
  end
  return closure tprime
end

##########################
## MAIN START
##########################

# Read the file
filename = ARGV[0]
puts "Reading from: #{filename}"
puts ""
filestring = ""
File.open(filename, 'r') do |file|  
  file.each do |line|
    filestring << line
  end
end

# Replace '|' with '\n|' to make parsing easier
filestring.gsub!(/\|/, "\n|")

# Parse the grammar
current_production = nil
filestring.split("\n").each do |line|
  if !line.match(/^\s*$/)
    tokens = line.gsub(/\s+/m, ' ').strip.split(" ")
    i = 0
    rhs = ""
    tokens.each do |token|
      if i == 0 and token != '|'
        current_production = token
        $productions[current_production] ||= []
        grammar_symbols << token unless grammar_symbols.include?(token)
      elsif token != '->' and token != '|'
        rhs << token
        grammar_symbols << token unless grammar_symbols.include?(token)
      end
      root_nonterminal = current_production if token == '$'
      i += 1
    end
    $productions[current_production] << rhs
  end
end


# Find the item sets of the LR(0) parse table
states = []
gotos = []
$productions[root_nonterminal].each do |rhs| # create the first set
  # if rhs == 'lambda' then rhs = "" end
  states << ( closure [[root_nonterminal, rhs, 0]] )
end
m = 0
begin
  m = states.size
  states.each do |i|
    grammar_symbols.each do |x|
      j = goto(i, x)
      if !j.empty? and !states.include? j
        states << j
        gotos << "Goto(#{states.index(i)},#{x}) = #{states.index(j)}"
      end
    end
  end
end while states.size == m

# Print out the results
puts "Grammar Rules"
$productions.each do |key, value|
  value.each do |rhs|
    puts "#{key} -> #{rhs}"
  end
end
puts ""

puts "Canonical LR States"
i = 0
states.each do |itemset|
  j = 0
  itemset.each do |item|
    if j == 0
      print "State #{i}: "
    else
      print "#{' '*("State #{i}:").length} "
    end
    rhs_with_dot = item[1].clone
    rhs_with_dot.insert(item[2], ".")
    puts "#{item[0]} -> #{rhs_with_dot}"
    j += 1
  end
  i += 1
end
puts ""

puts "Canonical Gotos"
gotos.each do |g|
  puts g
end

