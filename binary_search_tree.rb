class Node
  attr_reader :data
  attr_accessor :left_child, :right_child

  def initialize(data = nil, left_child = nil, right_child = nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end
end

class Tree
  attr_reader :root

  def initialize(array)
    @array = array
    @root = build_tree(@array.sort!.uniq!)
  end

  def build_tree(array, starting = 0, ending = array.length - 1)
    return nil if starting > ending

    mid = (starting + ending) / 2
    root = Node.new(array[mid])
    root.left_child = build_tree(array, starting, mid - 1)
    root.right_child = build_tree(array, mid + 1, ending)
    root
  end

  def insert(root, key)
    return Node.new(key) if root == nil
    
    if root.data == key
      root
    elsif root.data < key
      root.right_child = insert(root.right_child, key)
    else
      root.left_child = insert(root.left_child, key)
    end
    root
  end
end

tree = Tree.new([4, 1, 0, 2, 3, 2, 3, 4, 8, 7])
tree.insert(tree.root, 9)
tree.insert(tree.root, -1)
p tree.root.left_child
