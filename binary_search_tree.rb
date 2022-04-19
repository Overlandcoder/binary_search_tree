class Node
  def initialize(data = nil, left_child = nil, right_child = nil)
    @data = data
    @left_child = left_child
    @right_child = right_child
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @array = array
    build_tree(@array.sort!.uniq!)
  end

  def build_tree(array)
  end
end

Tree.new([4, 1, 0, 2, 3, 2, 3, 4, 8, 7])
