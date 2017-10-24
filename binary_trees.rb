class Node
  attr_accessor :value, :left_child, :right_child

  def initialize(value, left_child = nil, right_child=nil)
    @value = value
    @left_child = left_child
    @right_child = right_child
  end

end

class Tree
  attr_accessor :root

  def initialize
    @root = nil
  end

  #this method will build stacked trees if set up so, but shuffles to avoid
  def build_tree(arr)
    #arr.shuffle!
    arr.each do |x|
      if @root == nil
        @root = Node.new(x)
      else
        current_node = @root
        until current_node == nil
          if x < current_node.value
            parent = current_node
            direction = "left"
            current_node = current_node.left_child
          elsif x > current_node.value
            parent = current_node
            direction = "right"
            current_node = current_node.right_child
          end
        end
        if direction == "left"
          parent.left_child = Node.new(x)
        elsif direction == "right"
          parent.right_child = Node.new(x)
        end
      end
    end
  end

  def breadth_first_search(data)
    found_in = nil
    queue = []
    queue.push @root
    queue.each do |node|
      puts "\ncurrently searching #{node}found value #{node.value}\n"
      if node.value == data
        found_in = node
        break
      else
        if node.left_child
          queue.push(node.left_child)
        end
        if node.right_child
          queue.push(node.right_child)
        end
      end
    end
    found_in
  end

  #iterative depth search
  def depth_first_search(data)
    found_in = nil
    queue = []
    queue.push @root
    until queue.empty?
      puts "\ncurrently searching #{queue[0]}found value #{queue[0].value}\n"
      if queue[0].value == data
        found_in = queue[0]
        queue.clear
      else
        delete_index = 0
        if queue[0].left_child
          queue.unshift(queue[0].left_child)
          delete_index += 1
        end
        if queue[delete_index].right_child
          queue.unshift(queue[delete_index].right_child)
          delete_index += 1
        end
      end
      if !queue.empty?
        queue.delete_at(delete_index)
      end
    end
    found_in
  end

  #recursive depth_first_search
  def dfs_rec(data, target_node)
    if target_node == nil || target_node.value == data
      if target_node
        puts "searching #{target_node} and found #{target_node.value}"
      end
        return target_node
    else
      if data < target_node.value
        dfs_rec(data, target_node.left_child)
      else
        dfs_rec(data, target_node.right_child)
      end
    end
  end








end
