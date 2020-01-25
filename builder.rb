require './ruler.rb'
require './handler.rb'
class Board
  include Rules
  NEW_LINE = "  --+-------+-------+-------+--"
  NEW_SPACER = "    |       |       |       |"
  attr_accessor :board_matrix
  def initialize
    @board_matrix = Array.new()
    DEFAULT_BOARD.each_with_index do |row, y|
      row_build = Array.new
      row.each_with_index do |col, x|
        row_build<<Pawn.new(col, x+y, y, true)
      end
      @board_matrix<<row_build
    end
    boot()
  end
  def build
    puts "\n\n"
    puts NEW_SPACER
    puts NEW_LINE
    puts NEW_SPACER
    print "    "
    board_iterator do |x_index, y_index, data, scope| 
      case scope
      when :x
        print "|   #{board_matrix[y_index][x_index].render}   "
      when :y
        puts "|"
        puts NEW_SPACER
        puts NEW_LINE
        puts NEW_SPACER
        print "    "
      end
    end
    puts "\n\n"
  end
  def end?
    winner = false
    check do |sub|
      temp = Array.new
      sub.each do |pawn|
        temp << pawn.render
      end
      if temp.uniq.length==1 then winner=temp[0]; end
    end
    return winner
  end
end
