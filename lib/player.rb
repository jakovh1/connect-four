# frozen_string_literal: true

require 'colorize'

class Player
  attr_accessor :symbol

  def initialize(color)
    @color = color
    @symbol = '⚫'.colorize(color.to_sym)
  end

  def make_move(cage)
    column = -1

    until (1..7).include?(column)
      puts "Player #{@color} (#{@symbol}), please enter the column [1-7], where you want to insert your piece."
      column = $stdin.gets.chomp.to_i
      insert_call = cage.insert_piece(Integer(column) - 1, @symbol)
      column = -1 unless insert_call.is_a?(Array) || insert_call[0] == 'W'
    end

    insert_call
  end
end
