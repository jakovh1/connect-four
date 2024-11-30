# frozen_string_literal: true

require 'colorize'

class Cage
  attr_accessor :cage_array

  def initialize
    @cage_array = Array.new(6) { Array.new(7, '○') }
    @combination_piece_counter = 0
  end

  def print_cage
    @cage_array.each_with_index do |subarray, index|
      print '| '
      subarray.each_with_index do |element, index_sub|
        print index_sub < (subarray.length - 1) ? "#{element}  : " : "#{element}  |\n"
      end
      puts if index < @cage_array.length - 1
    end
    puts ' ----------------------------------'
    puts '  1    2    3    4    5    6    7'
  end

  def insert_piece(column, colored_symbol)
    (@cage_array.length - 1).downto(0) do |row|
      if @cage_array[row][column] == '○'
        @cage_array[row][column] = colored_symbol
        # check_game_state(row, column, colored_symbol)
        return check_game_state(row, column, colored_symbol) == 4 ? "We have a winner! #{colored_symbol} has won." : [column, row, colored_symbol]
      elsif row.zero?
        return 'The column is filled, insert the piece in other column.'
      end
    end
  end

  private

  def check_game_state(row, column, colored_piece)
    vertical = vertical_check(row, column, colored_piece)
    horizontal = horizontal_check(row, column, colored_piece)
    diagonal = [diagonal_check(row, column, colored_piece, 1), diagonal_check(row, column, colored_piece, -1)].max
    [vertical, horizontal, diagonal].max
  end

  def vertical_check(row, column, colored_piece)
    consecutive_pieces = 1
    (row + 1).upto(5) do |r|
      break if @cage_array[r][column] != colored_piece

      consecutive_pieces += 1
    end
    consecutive_pieces
  end

  def horizontal_check(row, column, colored_piece)
    consecutive_pieces = 1

    (column - 1).downto(0) do |c|
      break if @cage_array[row][c] != colored_piece

      consecutive_pieces += 1
    end
    (column + 1).upto(6) do |c|
      break if @cage_array[row][c] != colored_piece

      consecutive_pieces += 1
    end

    consecutive_pieces
  end

  def diagonal_check(row, column, colored_piece, column_direction)
    consecutive_pieces = 1
    starting_pos = [row.dup, column.dup]

    while (row - 1) >= 0 && (column + column_direction).between?(0, 6)
      row -= 1
      column += column_direction
      break if @cage_array[row][column] != colored_piece

      consecutive_pieces += 1
    end

    row = starting_pos[0]
    column = starting_pos[1]

    while (row + 1) <= 5 && (column + (column_direction * -1)).between?(0, 6)
      row += 1
      column += column_direction * -1
      break if @cage_array[row][column] != colored_piece

      consecutive_pieces += 1
    end

    consecutive_pieces
  end
end
