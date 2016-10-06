require_relative 'main'
require_relative 'trie'
require 'pry'

occurences1 = [12,3,4],[2,5,6,7],[5,6,7] # yes plagiarism - 4 5 6
occurences2 = [12,3,4],[2,5,6,7],[6,7] # yes plagiarism 4 5 6
occurences3 = [12],[2,5,6,7],[14] # no plagiarism

puts is_consecutive(occurences1) # true
puts is_consecutive(occurences2) # true
puts is_consecutive(occurences3) # false


synonyms = "blue yellow red green purple orange pink black"
input1 = "red can you tell if there is a yellow newspaper i saw a yellow dog"
input2 = "green can you tell if there is a black newspaper i saw a blue dog"

# assumign there are at least N words in a string
# number of tuples of length N in a string is equal to the number of words in the string - (N-1)
