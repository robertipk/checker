require_relative 'trie'
require 'pry'

syns = File.read("syns.txt").split(" ")
input1 = File.read("file1.txt").split(" ")
input2 = File.read("file2.txt").split(" ")
#
#
# # this hash stores all occurences of each synonym in string2
syns_hash = Hash.new
syns.each do |word|
  syns_hash[word] = Array.new
end
#
string2_trie = Trie.new
# # store all words in file2 into the trie
for x in 0...input2.length
  string2_trie.insert(input2[x],x)
end
binding.pry
# check all n-tuples of input1. N defaults to 3



# Returns true if tuple is found in trie
def detect_p(tuple,trie,index,tuple_length,synonyms)
  for x in 0...tuple_length
    word = tuple[0]
    if is_synonym(word)
      if !trie.contains(word)
        return false
      end
    end
  end
  true
end

# checks if a word is in the list of synonyms
def is_synonym(synonyms,word)
  if synonyms.has_key?(word)
    return true
  else
    return false
  end
end

# given the occurenes of each of the words of the tuple in string2
# check if a consecutive chains exists
# assumes tuple is of length 3
# for example [0,2,3,4,5],[6,8,11],[7,10,13] will return true because the consecutive sequence 5-6-7 is present
def is_consecutive(occurences)
  tuple_length = occurences.length
  for x in 0...occurences[0].length
    if occurences[1].include?(occurences[0][x]+1)
      for y in 0...occurences[1].length
        if occurences[2].include?(occurences[1][y]+1)
          return true
        end
      end
    end
  end
  false
end
