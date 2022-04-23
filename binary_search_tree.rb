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

  def insert(node = root, value)
    return Node.new(value) if node == nil
    
    if value < node.data
      node.left = insert(node.left, value)
    elsif value > node.data
      node.right = insert(node.right, value)
    end
    node
  end

  def delete(node = root, value)
    return node if node.nil?

    if value < node.data
      node.left = delete(node.left, value)
    elsif value > node.data
      node.right = delete(node.right, value)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      temp = inorder_successor(node)
      temp.left = node.left
      return node = temp
    end
    node
  end

  def inorder_successor(node)
    node = node.right
    until node.left.nil?
      node = node.left
    end
    node
  end

  def find(node = root, value)
    return nil if node.nil?
    return node if node.data == value

    if value < node.data
      find(node.left, value)
    elsif value > node.data
      find(node.right, value)
    end
  end
end

tree = Tree.new([4, 1, 0, 2, 3, 2, 3, 4, 8, 7])
p [4, 1, 0, 2, 3, 2, 3, 4, 8, 7].sort!.uniq!
p tree.root.left
tree.insert(-1)
tree.insert(-1)
p tree.root.left
puts ""
p tree.find(7)
