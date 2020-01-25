require './handler.rb'
require './builder.rb'
require './ruler.rb'
class Game
  attr_accessor :player_array, :turns, :board
  def initialize
    puts 'Welcome to Tic-Tac-Toe'
    @player_array = Array.new()
    @player_array << Player.new('Player X', 'X', self)
    @player_array << Player.new('Player Y', 'O', self)
    @board = Board.new()
    @turns = 0
    new_turn
  end
  def new_turn
    @board.build()
    turn_data = player_array[turns%2].turn
    if player_array[turns%2].sign(turn_data[1], turn_data[0])
      if board.end?
        @board.build() 
        game_over
        #TODO ADD RESTART GAME SUPPORT. MAKE SYMBOLS CLASS
      else
        @turns += 1
        new_turn
      end
    else
      puts "Invalid Move. Try again."
      new_turn
    end
  end
  def game_over
    puts board.end? + " won!"
    puts "Continue? [Y/N] > "
    if gets.chomp.downcase == "y" then Game.new end
  end
end
Game.new
