require 'pry-byebug'

class Node
  attr_accessor :data, :left, :right

  def initialize(data = nil, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

class Tree
  attr_reader :root, :array

  def initialize(array)
    @array = array
    @root = build_tree(@array.sort!.uniq!)
  end

  def build_tree(array, starting = 0, ending = array.length - 1)
    return nil if starting > ending

    mid = (starting + ending) / 2
    root = Node.new(array[mid])
    root.left = build_tree(array, starting, mid - 1)
    root.right = build_tree(array, mid + 1, ending)
    root
  end

  def insert(root, value)
    return Node.new(value) if root == nil
    
    if root.data == value
      root
    elsif root.data < value
      root.right = insert(root.right, value)
    else
      root.left = insert(root.left, value)
    end
    root
  end

  def delete(node, value)
    if node.left.data == value
      return node.left = nil if no_children?(node.left)

      if one_child?(node.left)
        return node.left = node.left.left if !node.left.nil?
        return node.right = node.left.right if !node.right.nil?
      end

      if two_children?(node.left)

      end
    end

    if node.right.data == value
      return node.right = nil if no_children?(node.right)

      if one_child?(node.right)
        return node.right = node.right.left if !node.left.nil?
        return node.right = node.right.right if !node.right.nil?
      end

      if two_children?(node.right)
          
      end
    end

    if node.data < value
      delete(node.right, value)
    else
      delete(node.left, value)
    end
  end

  def no_children?(node)
    node.left.nil? && node.right.nil?
  end

  def one_child?(node)
    node.left.nil? && !node.right.nil? || !node.left.nil? && node.right.nil?
  end

  def two_children?(node)
    !node.left.nil? && !node.right.nil?
  end
end

tree = Tree.new([4, 1, 0, 2, 3, 2, 3, 4, 8, 7])
p [4, 1, 0, 2, 3, 2, 3, 4, 8, 7].sort!.uniq!
tree.insert(tree.root, 9)
tree.insert(tree.root, -1)
p tree.root.left
tree.delete(tree.root, 0)
p ""
p tree.root.left
