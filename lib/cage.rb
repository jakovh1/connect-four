# frozen_string_literal: true

require 'colorize'

# This class provides methods to:
# - insert a piece into the cage
# - print the cage (private)
# - check for a winner
class Cage
  attr_reader :cage_array, :moves_made

  def initialize
    @cage_array = Array.new(6) { Array.new(7, '○') }
    @combination_piece_counter = 0
    @moves_made = 0
    print_cage
  end

  def insert_piece(column, colored_symbol)
    # Loops to the first available spot in the given column
    (@cage_array.length - 1).downto(0) do |row|
      if @cage_array[row][column] == '○'
        @cage_array[row][column] = colored_symbol
        @moves_made += 1
        print_cage

        # After every insertion, it check whether 4 pieces of the same color are connected
        return check_game_state(row, column, colored_symbol) == 4 ? "We have a winner! #{colored_symbol} has won." : [column, row, colored_symbol]
      elsif row.zero?
        return 'The column is filled, insert the piece in other column.'
      end
    end
  end

  private

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
    diagonal_check_up(row, column, colored_piece, column_direction) + diagonal_check_down(row, column, colored_piece, column_direction)
  end

  def diagonal_check_up(row, column, colored_piece, column_direction)
    consecutive_pieces = 1

    while (row - 1) >= 0 && (column + column_direction).between?(0, 6)
      row -= 1
      column += column_direction
      break if @cage_array[row][column] != colored_piece

      consecutive_pieces += 1
    end
    consecutive_pieces
  end

  def diagonal_check_down(row, column, colored_piece, column_direction)
    consecutive_pieces = 0

    while (row + 1) <= 5 && (column + (column_direction * -1)).between?(0, 6)
      row += 1
      column += column_direction * -1
      break if @cage_array[row][column] != colored_piece

      consecutive_pieces += 1
    end

    consecutive_pieces
  end
end
