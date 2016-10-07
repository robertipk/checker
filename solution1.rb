# Robert Ip
require_relative 'utilities'

# solution 1 - using hashes

user_responses = get_user_input
puts "Enter tuple length:"
tuple_length = gets.chomp.to_i
syns = File.read(user_responses[0]).split(" ")
input1 = File.read(user_responses[1]).split(" ")
input2 = File.read(user_responses[2]).split(" ")

validate_tuple_length(input1.length,tuple_length)

# store all synonyms in a hash for easy lookup
syns_hash = Hash.new
syns.each do |word|
  syns_hash[word] = true
end

# choose an arbitrary synonym X from the list and replace all synonyms in both input files with X
synonym = syns[0]

for x in 0...input1.length
  if syns_hash.has_key?(input1[x])
    input1[x] = synonym
  end
end

for x in 0...input2.length
  if syns_hash.has_key?(input2[x])
    input2[x] = synonym
  end
end

# store all N tuples of file1 in a hash
hash1 = Hash.new
for x in 0...input1.length-tuple_length+1
  tuple = input1[x] + " " + input1[x+1] + " " + input1[x+2]
  hash1[tuple] = true
end

# store all N tuples of file2 in a hash
hash2 = Hash.new
for x in 0...input2.length-tuple_length+1
  tuple = input2[x] + " " + input2[x+1] + " " + input2[x+2]
  hash2[tuple] = true
end

# iterate over each tuple in file1. If it overlaps with any tuple of file2, increase plagiarism count
plagariasm_count = 0
hash1.keys.each do |k|
  if hash2.has_key?(k)
    plagariasm_count+=1
  end
end

num_tuples = input1.length-tuple_length+1
puts format_quotient(plagariasm_count,num_tuples)
