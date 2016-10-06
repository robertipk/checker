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

# this hash will stores all occurences of each synonym in file2, if the synonym is present
# key: the synonym
# value: an array containing all the indices at which the synonym appears in file2
syns_hash = Hash.new
syns.each do |word|
  syns_hash[word] = Array.new
end

# store all words in file2 into the trie
string2_trie = Trie.new

for x in 0...input2.length
  if syns_hash.has_key?(input2[x])
    syns_hash[input2[x]] << x
  end
  string2_trie.insert(input2[x],x)
end

# an array containing all the indices in file2 at which a synonym was found
synonym_indices = Array.new
syns_hash.values.each do |indices|
  if indices.length>0
    synonym_indices += indices
  end
end

num_matches = 0
start_index = 0
# check all n-tuples of input1. N defaults to 3
while start_index < input1.length-2
  tuple = [input1[start_index],input1[start_index+1],input1[start_index+2]]
  response = detect_p(tuple,string2_trie,3,syns_hash,synonym_indices)
    # puts "found a match for " + input1[start_index] + " " + input1[start_index+1] + " " + input1[start_index+2]
  if response==-1
    # all words in the tuple were found in File2, but not in consecutive order. No plagiarism detected
    start_index+=1
  elsif response==999
    # plagiarism detected
    num_matches+=1
    start_index+=1
  elsif response>-1 && response<3
    # at least one word in the tuple was not found in File2, so skip ahead to the next tuple
    start_index+=response+1
  end
end

puts num_matches
