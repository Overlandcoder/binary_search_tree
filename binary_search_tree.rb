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
end

Tree.new([4, 1, 0, 2, 3, 2, 3, 4, 8, 7])
