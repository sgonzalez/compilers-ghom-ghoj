class AbstractNode
  attr_accessor :node_type, :leftmost_child, :leftmost_sibling, :right_sibling, :parent, :is_visited

  def initialize(node_type, leftmost_child=nil, leftmost_sibling=nil, right_sibling=nil, parent=nil)
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
    begin
      childs << ptr
      ptr = ptr.right_sibling
    end while ptr != nil
    childs
  end

  def left_siblings
    siblings = []
    ptr = @leftmost_sibling
    begin
      siblings << ptr
      ptr = ptr.right_sibling
    end while ptr != self
    siblings
  end

  def right_siblings
    siblings = []
    ptr = self
    begin
      siblings << ptr
      ptr = ptr.right_sibling
    end while ptr != nil
    siblings
  end

  def make_siblings(y)
    xsibs = self
    while xsibs.right_siblings != nil do
      xsibs = xsibs.right_sibling
    end
    ysibs = y.leftmost_sibling
    xsibs.right_sibling = ysibs
    ysibs.leftmost_sibling = xsibs.leftmost_sibling
    ysibs.parent = xsibs.parent
    while ysibs.right_siblings != nil do
      ysibs = ysibs.right_sibling
      ysibs.leftmost_sibling = xsibs.leftmost_sibling
      ysibs.parent = xsibs.parent
    end
    ysibs
  end

  def adopt_children(y)
    if self.leftmost_child != nil
      self.leftmost_child.make_siblings(y)
    else
      ysibs = y.leftmost_sibling
      self.leftmost_child = ysibs
      while ysibs != nil do
        ysibs.parent = self
        ysibs = ysibs.right_sibling
      end
    end
    self
  end

  def make_family(op, *children)
    child_head = children[0]
    children.each do |child|
      if child != child_head
        child_head.make_siblings(child)
      end
    end
    return AbstractNode.new(op).adopt_children(child_head)
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
