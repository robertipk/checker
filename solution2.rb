# Robert Ip
require_relative 'trie'
require_relative 'utilities'

# solution 2 - using a trie

user_responses = get_user_input
syns = File.read(user_responses[0]).split(" ")
input1 = File.read(user_responses[1]).split(" ")
input2 = File.read(user_responses[2]).split(" ")

# assume tuple length is 3
validate_tuple_length(input1.length, 3)

# this hash will stores all occurences of each synonym in file2, if the synonym is present
# key: the synonym
# value: an array containing all the indices at which the synonym appears in file2
syns_hash = Hash.new
syns.each do |word|
  syns_hash[word] = Array.new
end

string2_trie = Trie.new
# an array containing all the indices in file2 at which any synonym was found
synonym_indices = Array.new

# store all words in file2 into the trie
# if the word is a synonym, add its index to synonym_indices
for x in 0...input2.length
  if syns_hash.has_key?(input2[x])
    synonym_indices << x
  end
  string2_trie.insert(input2[x],x)
end

plagariasm_count = 0
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
    plagariasm_count+=1
    start_index+=1
  elsif response>-1 && response<3
    # at least one word in the tuple was not found in File2, so skip ahead to the next tuple
    start_index+=response+1
  end
end
num_tuples = input1.length-2
puts format_quotient(plagariasm_count,num_tuples)
