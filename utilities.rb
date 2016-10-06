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
      return false
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
          return true
        end
      end
    end
  end
  false
end
