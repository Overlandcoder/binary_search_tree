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

  def insert(value, node = root)
    return Node.new(value) if node.nil?

    if value < node.data
      node.left = insert(value, node.left)
    elsif value > node.data
      node.right = insert(value, node.right)
    end
    node
  end

  def delete(value, node = root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
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
    node = node.left until node.left.nil?
    node
  end

  def find(value, node = root)
    return nil if node.nil?
    return node if node.data == value

    if value < node.data
      find(value, node.left)
    elsif value > node.data
      find(value, node.right)
    end
  end

  def level_order
    return if root.nil?

    queue = [@root]
    result = []
    until queue.empty?
      node = queue.shift
      block_given? ? yield(node) : result << node.data
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
    result unless block_given?
  end

  def inorder

  end

  def height(node, height = 0)
    return height - 1 if node.nil?

    height += 1

    [height(node.left, height), height(node.right, height)].max
  end

  def depth(node, root, depth = 0)
    return depth if root == node

    depth += 1

    if node.data < root.data
      depth(node, root.left, depth)
    elsif node.data > root.data
      depth(node, root.right, depth)
    end
  end
end

tree = Tree.new([4, 1, 0, 2, 3, 2, 3, 4, 8, 7])
p [4, 1, 0, 2, 3, 2, 3, 4, 8, 7].sort!.uniq!
p tree.root.left
tree.insert(-1)
tree.insert(-1)
tree.insert(9)
p tree.root.left
puts ''
p tree.root.right
p tree.level_order
p tree.height(tree.find(1))
p tree.depth(tree.find(4), tree.root)
