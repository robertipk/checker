require_relative 'trie'
require_relative 'trie_node'

# Returns true if tuple is found in trie
def detect_p(tuple,trie,tuple_length,synonyms_hash,synonym_indices)
  occurences = Array.new
  for x in 0...tuple_length
    word = tuple[x]
    indices = Array.new
    if is_synonym(synonyms_hash,word)
      indices = synonym_indices
    else
      indices = trie.contains(word)
    end
    if indices.length==0
      # if the word does not exist, return index of the tuple which was not found
      # the index ranges from 0 to tuple_length-1
      return x
    elsif indices.length>0
      occurences<<indices
    end
  end
  is_consecutive(occurences)
end

# checks if a word is in the list of synonyms
def is_synonym(synonyms_hash,word)
  if synonyms_hash.has_key?(word)
    return true
  else
    return false
  end
end

# given the occurenes of each of the words of each word of the tuple in string2
# check if a consecutive chains exists
# assumes tuple is of length 3
# for example [0,2,3,4,5],[6,8,11],[7,10,13] will return true because the consecutive sequence 5-6-7 is present
def is_consecutive(occurences)
  tuple_length = occurences.length
  for x in 0...occurences[0].length
    if occurences[1].include?(occurences[0][x]+1)
      for y in 0...occurences[1].length
        if occurences[2].include?(occurences[1][y]+1)
          # ideally I would like to return a boolean, but detect_p must return an integer
          return 999
        end
      end
    end
  end
  -1
end

# asks the user for the txt files
# returns the name of the files as an array
def get_user_input
  puts "Enter the name of the txt file containing the synonyms"
  syns_txt = gets.chomp
  puts "Enter the name of inputfile1 (the txt file that you want to check for plagiarism)"
  txt_to_check = gets.chomp
  puts "Enter the name of inputfile2 (the txt file that inputfile1 will be checked against)"
  source_file = gets.chomp
  [syns_txt,txt_to_check,source_file]
end
