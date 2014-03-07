#!/usr/bin/ruby

#### Santiago Gonzalez, Jeremy Kerr, Brianna Fidder, Benjamin Fuller, Paulo Iza

def is_terminal x
  
end


def is_nonterminal x
  
end


def is_lambda x
  
end


def progress items
  
end


def symbols rules
  
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
    puts line
    filestring << line
  end
end

# Replace '|' with '\n|' to make parsing easier
filestring.gsub!(/\|/, "\n|")

# Parse the grammar
productions = {}
current_production = nil
filestring.split("\n").each do |line|
  if !line.match(/^\s*$/)
    tokens = line.gsub(/\s+/m, ' ').strip.split(" ")
    i = 0
    rhs = ""
    tokens.each do |token|
      if i == 0 and token != '|'
        current_production = token
        productions[current_production] ||= []
      elsif token != '->' and token != '|'
        rhs << token
      end
      i += 1
    end
    productions[current_production] << rhs
  end
end


# Find the item sets of the LR(0) parse table
states = []

states << []
productions.each do |key, value|
  value.each do |rhs|
    if rhs == 'lambda' then rhs = "" end
    states[0] << [key, rhs, 0]
  end
end

# Print out the item sets
states.each do |itemset|
  p itemset
end

