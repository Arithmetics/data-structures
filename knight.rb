class Knight
  attr_accessor :start

  def initialize
    @start = nil
  end

  def find_path(start,target)
    @start = Move.new(nil, start)
    found_in = nil
    queue = []
    queue.push @start
    queue.each do |x|
      if x.location == target
        found_in = x
        break
      else
        x.make_children
        x.children.each do |y|
          queue.push(y)
        end
      end
    end
    move_plan = []
    current = found_in
    move_plan.push(current.location)
    until !current.parent
      current = current.parent
      move_plan.unshift(current.location)
    end
    puts "Made it in #{move_plan.size - 1} moves.\nHere is your path:"
    move_plan.each do |x|
      puts "#{x}\n"
    end
  end
end


class Move
  attr_accessor :parent, :location, :children

  def initialize(parent, location)
    @parent = parent
    @location = location
    @children = []
  end

  def allowed_moves
    allowed_squares = []
    shifts = [[-2,1],[-1,2],[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1]]
    shifts.each do |x|
      x[0] += @location[0]
      x[1] += @location[1]
      if x[0] > 0 && x[0] < 9 && x[1] > 0 && x[1] < 9
        allowed_squares.push(x)
      end
    end
    allowed_squares
  end

  def make_children
    allowed_moves.each do |x|
      @children.push(Move.new(self, x))
    end
  end

end
