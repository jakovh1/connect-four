# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/cage'

describe Player do
  describe '#make_move' do
    it 'Inserts a red piece and returns the position where it is inserted.' do
      cage = Cage.new
      player_red = Player.new('red')
      player_yellow = Player.new('yellow')

      allow($stdin).to receive(:gets).and_return('1')
      expect(player_red.make_move(cage)).to eql([0, 5, player_red.symbol])
    end

    it 'Checks for invalid inputs, inserts a red piece and returns the position where it is inserted.' do
      cage = Cage.new
      player_red = Player.new('red')
      player_yellow = Player.new('yellow')

      allow($stdin).to receive(:gets).and_return('-1', '100', '500', '1')
      expect(player_red.make_move(cage)).to eql([0, 5, player_red.symbol])
    end
    
    it 'Fills the first row alternately with red and yellow pieces and returns the positions where they are inserted.' do
      cage = Cage.new
      player_red = Player.new('red')
      player_yellow = Player.new('yellow')

      allow($stdin).to receive(:gets).and_return('1', '2', '3', '4', '5', '6', '7')
      expect(player_red.make_move(cage)).to eql([0, 5, player_red.symbol])
      expect(player_yellow.make_move(cage)).to eql([1, 5, player_yellow.symbol])
      expect(player_red.make_move(cage)).to eql([2, 5, player_red.symbol])
      expect(player_yellow.make_move(cage)).to eql([3, 5, player_yellow.symbol])
      expect(player_red.make_move(cage)).to eql([4, 5, player_red.symbol])
      expect(player_yellow.make_move(cage)).to eql([5, 5, player_yellow.symbol])
      expect(player_red.make_move(cage)).to eql([6, 5, player_red.symbol])
    end
  end
end