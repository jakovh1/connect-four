# frozen_string_literal: true

require 'colorize'

class Player
  attr_accessor

  def initialize(color)
    @color = color
    @symbol = '⚫'.colorize(color.to_sym)
  end

  def make_move(cage)
    column = -1

    until column.match(/^[1-7]$/)
      puts "Player #{@color} (#{@symbol}), please enter the column [1-7], where you want to insert your piece."
      column = $stdin.gets.chomp
    end

    cage.insert_piece(column - 1, @symbol)
  end
end
