require_relative 'trie'
require_relative 'utilities'

require 'pry'
# I tested my program using syns.txt, file1.txt, and file2.txt
# but the program also accepts command line arguments, as specified in the assignment guidelines
# syns = File.read("syns.txt").split(" ")
# input1 = File.read("file1.txt").split(" ")
# input2 = File.read("file2.txt").split(" ")

user_responses = get_user_input
syns = File.read(user_responses[0]).split(" ")
input1 = File.read(user_responses[1]).split(" ")
input2 = File.read(user_responses[2]).split(" ")


if input1.length < 3
  puts "0% - plagiarism impossible if length of input is less than tuple length"
  exit
end

# store all synonyms in a hash for easy lookup
syns_hash = Hash.new
syns.each do |word|
  syns_hash[word] = true
end

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

plagariasm_count = 0
hash1 = Hash.new
for x in 0...input1.length-2
  tuple = input1[x] + " " + input1[x+1] + " " + input1[x+2]
  hash1[tuple] = true
end

hash2 = Hash.new
for x in 0...input2.length-2
  tuple = input2[x] + " " + input2[x+1] + " " + input2[x+2]
  hash2[tuple] = true
end

hash1.keys.each do |k|
  if hash2.has_key?(k)
    plagariasm_count+=1
  end
end

num_tuples = input1.length-2
puts format_quotient(plagariasm_count,num_tuples)
# puts ((num_matches.to_f/num_tuples)).round(2).to_s + "%"
