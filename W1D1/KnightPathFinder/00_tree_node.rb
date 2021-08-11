require 'byebug'
module Searchable

  def dfs(target_value)
    return self if self.value == target_value 
      _children.each do |node|
         current = node.dfs(target_value)
        return current if current
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty? 
      current = queue.shift 
      return current if current.value == target_value

      current._children.each do |node|
        queue << node 
      end
    end
    nil 
  end

end


class PolyTreeNode
  include Searchable
  attr_reader :parent 
  attr_accessor :value 

  def initialize(value)
    @parent = nil
    @children = Array.new([])
    @value = value 
  end

  def parent=(parent_node)
    @parent._children.delete(self) if @parent 
    @parent = parent_node
    parent_node._children << self unless parent_node.nil?
  end

  def children
    @children.dup
  end
  
  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise error if !children.include?(child_node)
    child_node.parent = nil
  end

  protected 
  def _children
    @children
  end


end

# n = PolyTreeNode.new(3)
# p n.dfs(3)


  
  
