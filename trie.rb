# Robert Ip
# assumption - all members of string2 consist solely of lowercase letters
require_relative 'trie_node'

class Trie
  attr_accessor :root
  def initialize()
   @root = Trie_Node.new
  end

  # checks if a word (from string1) exists in string2
  # if the word does not exist, returns -1
  # if the word exists, returns all the occurences of the word in string2
  def contains(word)
    if word==nil || word==""
      return []
    else
      node = @root.children[word[0]]
      if !node
        return []
      end
      for x in 1...word.length
        if node.children.has_key?(word[x])
          node = node.children[word[x]]
        else
          return []
        end
      end
      if node.indices.length==0
        # reached last letter of the word, but the word does not exist
        return []
      elsif node.indices.length>=0
        # return all positions of the word in string2
        return node.indices
      end
    end
  end
  # inserts word into the trie, along with its index in string2
  # returns nothing
  def insert(word,index)
   node = @root
   for x in 0...word.length
     if node.children.has_key?(word[x])
       node = node.children[word[x]]
     else
       new_node = Trie_Node.new(word[x])
       node.children[word[x]] = new_node
       node = new_node
     end
   end
   node.indices<<index
  end
end
