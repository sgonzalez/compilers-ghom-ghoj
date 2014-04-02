class AbstractNode
  attr_accessor :node_type, :leftmost_child, :leftmost_sibling, :right_sibling, :parent, :is_visited

  def initialize(node_type, leftmost_child, leftmost_sibling, right_sibling, parent)
    @node_type = node_type  # a symbol
    @leftmost_child = leftmost_child
    @leftmost_sibling = leftmost_sibling
    @right_sibling = right_sibling
    @parent = parent
    @is_visited = false
  end

  def children
    childs = []
    ptr = @leftmost_child
    do
      childs << ptr
      ptr = ptr.right_sibling
    until ptr == nil
    childs
  end

end


class ReflectiveVisitor
  
  def visit n
    self.dispatch n
  end
  
  def dispatch o
    self.default_visit o
  end
  
  def default_visit n
    n.children.each do |c|
      this.visit c
    end
  end
  
end


module NeedsBooleanPredicate
  attr_accessor :predicate
end

module NeedsCompatibleTypes
  
end


class IfNode < AbstractNode
  include NeedsBooleanPredicate
  
  def accept v
    v.visit self
  end
end

class ShiftNode < AbstractNode
  include NeedsCompatibleTypes
  
  def accept v
    v.visit self
  end
end


class TypeChecking < ReflectiveVisitor
  def visit n
    (class << obj; self; end).included_modules.each do |m|
      if m.class == NeedsBooleanPredicate
        n.accept(this)
      elsif m.class == NeedsCompatibleTypes
        n.accept(this)
      end
    end
  end
end