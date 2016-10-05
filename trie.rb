# Robert Ip
# assumption - all members of string2 consist solely of lowercase letters
class Trie_Node
  attr_accessor :letter,:indices,:children,
  def initializer(letter=nil)
   @letter = letter
   @indices = Array.new
   @children = Hash.new
  end
end

class Trie
  def initialize()
   @root = Trie_Node.new
  end

  # checks if a word (from string1) exists in string2
  # if the word does not exist, returns -1
  # if the word exists, returns all the occurences of the word in string2
  def contains(word)
    if word==nil || word==""
      return false
    else
      node = @root.children[word[0]]
      for x in 1...word.length
        if node.children.has_key?(word[x])
          node = node.children[word[x]]
        elsif !node.children.has_key?(word[x])
          return false
        end
      end
      if node.positions.length==0
        # reached last letter of the word, but the word does not exist
        return -1
      elsif node.positions.length>=0
        # return all positions of the word in string2
        return node.positions
      end
    end
  end
  # inserts word into the trie, along with its index in string2
  # returns nothing
  def insert(word,index)
   node = @root.children[word[0]]
   for x in 0...word.length
     if node.children.has_key?(word[x])
       node = node.children[word[x]]
     else
       new_node = Trie_Node.new(word[x])
       node.children[word[x]] = new_node
       node = new_node
     end
   end
   node.positions<<index
  end
end
