# frozen_string_literal: true

require_relative './cage'
require_relative './player'

# This class provides methods to:
# - start the game
# - toggle between players after every move
class Game
  def initialize
    @cage = Cage.new
    @player_red = Player.new('red')
    @player_yellow = Player.new('yellow')
    @winner = 'none'
    @current_player = @player_red
  end

  def play
    while @winner == 'none'
      move_result = @current_player.make_move(@cage)

      @winner = "Player #{@current_player.color.capitalize} has won the game." if move_result[0] == 'W'
      @winner = 'TIE' if @cage.moves_made == 42 && @winner == 'none'
      toggle_current_player
    end

    @winner
  end

  private

  def toggle_current_player
    return @current_player = @player_yellow if @current_player == @player_red

    @current_player = @player_red
  end
end