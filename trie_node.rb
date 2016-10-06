require 'pry'

class Trie_Node
  attr_accessor :letter,:indices,:children
  def initialize(letter=nil)
   @letter = letter
   @indices = []
   @children = Hash.new
  end
end
