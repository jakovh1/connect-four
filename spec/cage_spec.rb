# frozen_string_literal: true

require 'colorize'
require_relative '../lib/cage'

describe Cage do
  def find_last_available(cage, column)
    (cage.cage_array.length - 1).downto(0) do |row|
      return [column, row] if cage.cage_array[row][column] == '○'
    end
    'There is no more space in this column.'
  end

  describe '#print_cage' do
    it 'Prints the cage.' do
      cage = Cage.new

      expected_output = <<~BOARD
        | ○  : ○  : ○  : ○  : ○  : ○  : ○  |

        | ○  : ○  : ○  : ○  : ○  : ○  : ○  |

        | ○  : ○  : ○  : ○  : ○  : ○  : ○  |

        | ○  : ○  : ○  : ○  : ○  : ○  : ○  |

        | ○  : ○  : ○  : ○  : ○  : ○  : ○  |

        | ○  : ○  : ○  : ○  : ○  : ○  : ○  |
         ----------------------------------
          1    2    3    4    5    6    7
      BOARD
      expect { cage.print_cage }.to output(expected_output).to_stdout
    end
  end

  describe '#insert_piece' do
    it 'Inserts a piece into the cage and returns the array with updated [column, row, inserted symbol].' do
      cage = Cage.new
      column = 3
      colored_piece = '●'.colorize(:red)
      expected_output = find_last_available(cage, column).push(colored_piece)
      expect(cage.insert_piece(column, colored_piece)).to eql(expected_output)
    end
  end

  describe '#insert_piece' do
    it 'Tries to insert a piece into the filled column and returns the error message.' do
      cage = Cage.new
      column = 3
      colored_piece = '●'.colorize(:red)

      6.times do
        cage.insert_piece(column, colored_piece)
      end

      expect(cage.insert_piece(column, colored_piece)).to eql('The column is filled, insert the piece in other column.')
    end
  end

  describe '#check_game_state' do
    it 'Informs that red player is a winner with the consecutive pieces in vertical direction.' do
      cage = Cage.new
      column = 3
      colored_piece = '●'.colorize(:red)

      expect(cage.insert_piece(column, colored_piece)).to eql([3, 5, colored_piece])
      expect(cage.insert_piece(column, colored_piece)).to eql([3, 4, colored_piece])
      expect(cage.insert_piece(column, colored_piece)).to eql([3, 3, colored_piece])
      expect(cage.insert_piece(column, colored_piece)).to eql("We have a winner! #{colored_piece} has won.")

      cage.print_cage
    end

    it 'Informs us that yellow player is a winner with the consecutive pieces in horizontal direction.' do
      cage = Cage.new
      colored_piece = '●'.colorize(:yellow)
      row = 5

      expect(cage.insert_piece(1, colored_piece)).to eql([1, 5, colored_piece])
      expect(cage.insert_piece(2, colored_piece)).to eql([2, 5, colored_piece])
      expect(cage.insert_piece(3, colored_piece)).to eql([3, 5, colored_piece])
      expect(cage.insert_piece(4, colored_piece)).to eql("We have a winner! #{colored_piece} has won.")
      cage.print_cage
    end

    it 'Informs us that yellow player is a winner with the consecutive pieces in right-diagonal direction.' do
      cage = Cage.new
      yellow_piece = '●'.colorize(:yellow)
      red_piece = '●'.colorize(:red)

      expect(cage.insert_piece(1, yellow_piece)).to eql([1, 5, yellow_piece])
      expect(cage.insert_piece(2, red_piece)).to eql([2, 5, red_piece])
      expect(cage.insert_piece(2, yellow_piece)).to eql([2, 4, yellow_piece])
      expect(cage.insert_piece(1, red_piece)).to eql([1, 4, red_piece])
      expect(cage.insert_piece(3, yellow_piece)).to eql([3, 5, yellow_piece])
      expect(cage.insert_piece(3, red_piece)).to eql([3, 4, red_piece])
      expect(cage.insert_piece(3, yellow_piece)).to eql([3, 3, yellow_piece])
      expect(cage.insert_piece(4, red_piece)).to eql([4, 5, red_piece])
      expect(cage.insert_piece(4, yellow_piece)).to eql([4, 4, yellow_piece])
      expect(cage.insert_piece(4, red_piece)).to eql([4, 3, red_piece])
      expect(cage.insert_piece(4, yellow_piece)).to eql("We have a winner! #{yellow_piece} has won.")

      cage.print_cage
    end

    it 'Informs us that red player is a winner with the consecutive pieces in left-diagonal direction.' do
      cage = Cage.new
      yellow_piece = '●'.colorize(:yellow)
      red_piece = '●'.colorize(:red)

      expect(cage.insert_piece(1, red_piece)).to eql([1, 5, red_piece])
      expect(cage.insert_piece(2, yellow_piece)).to eql([2, 5, yellow_piece])
      expect(cage.insert_piece(4, red_piece)).to eql([4, 5, red_piece])
      expect(cage.insert_piece(3, yellow_piece)).to eql([3, 5, yellow_piece])
      expect(cage.insert_piece(4, red_piece)).to eql([4, 4, red_piece])
      expect(cage.insert_piece(2, yellow_piece)).to eql([2, 4, yellow_piece])
      expect(cage.insert_piece(1, red_piece)).to eql([1, 4, red_piece])
      expect(cage.insert_piece(1, yellow_piece)).to eql([1, 3, yellow_piece])
      expect(cage.insert_piece(1, red_piece)).to eql([1, 2, red_piece])
      expect(cage.insert_piece(4, yellow_piece)).to eql([4, 3, yellow_piece])
      expect(cage.insert_piece(2, red_piece)).to eql([2, 3, red_piece])
      expect(cage.insert_piece(4, yellow_piece)).to eql([4, 2, yellow_piece])
      expect(cage.insert_piece(3, red_piece)).to eql("We have a winner! #{red_piece} has won.")

      cage.print_cage
    end
  end

end
