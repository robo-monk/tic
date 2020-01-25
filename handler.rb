require './ruler.rb'
class Player
  include Rules
  attr_reader :name, :pawn_ch, :game
  def initialize name, pawn_ch, game
    print "\e[2J\e[f"
    @name = name
    @pawn_ch = pawn_ch
    @game = game
  end
  private
  def get_input
    clipper gets.chomp.to_i, (1..BOARD_DIMENSIONS**2)
  end
  public
  def turn
    puts ". . . . . . . . . . . . . . . . . ."
    print ">> #{@name} its your turn! >> "
    user_input = get_input-1
    row = (user_input/(BOARD_DIMENSIONS)).round()
    col = user_input%BOARD_DIMENSIONS
    return row, col
  end
  def sign x, y
    if game.board.access(x, y).purge?
      game.board.write(x, y, Pawn.new(pawn_ch, x, y))
    else return false end
  end
  def won
    puts "#{@name} won! "
  end
end

class Pawn
  include Rules
  attr_accessor :ch, :x, :y, :purgable
  def initialize ch, x, y, purgable=false
    @ch = ch
    @x = x
    @y = y
    @purgable = purgable
  end
  def render
    @ch
  end
  def purge?
    @purgable
  end
end
