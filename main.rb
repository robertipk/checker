require_relative 'trie'
require_relative 'utilities'

require 'pry'

syns = File.read("syns.txt").split(" ")
input1 = File.read("file1.txt").split(" ")
input2 = File.read("file2.txt").split(" ")
#
#
# this hash will stores all occurences of each synonym in string2, if the synonym is present
# key: the synonym     value: an array containing all the indices at which this synonym appears in strin
syns_hash = Hash.new
syns.each do |word|
  syns_hash[word] = Array.new
end

#
string2_trie = Trie.new
# # store all words in file2 into the trie
for x in 0...input2.length
  if syns_hash.has_key?(input2[x])
    syns_hash[input2[x]] << x
  end
  string2_trie.insert(input2[x],x)
end

# create an array containing all the indices in string2 at which a synonym was found
synonym_indices = Array.new
syns_hash.values.each do |indices|
  if indices.length>0
    synonym_indices += indices
  end
end
binding.pry
num_matches = 0
# check all n-tuples of input1. N defaults to 3
for x in 0...input1.length-2
  tuple = [input1[x],input1[x+1],input1[x+2]]
  if detect_p(tuple,string2_trie,3,syns_hash,synonym_indices)
    puts "found a match for " + input1[x] + " " + input1[x+1] + " " + input1[x+2]
    num_matches+=1
  end
end

puts num_matches/
