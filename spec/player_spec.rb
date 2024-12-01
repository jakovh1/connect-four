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
    
  end
end