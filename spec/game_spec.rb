# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#play' do
    it 'Plays a tie game.' do
      game = Game.new

      allow($stdin).to receive(:gets).and_return('1', '2', '3', '4', '5', '6', '7',
                                                 '2', '1', '4', '3', '6', '5', '7',
                                                 '2', '1', '3', '5', '4', '7', '6',
                                                 '3', '1', '5', '7', '6', '4', '2',
                                                 '7', '1', '3', '5', '5', '2', '6',
                                                 '4', '2', '6', '1', '3', '4', '7')
      expect(game.play).to eql('TIE')
    end

    it 'Plays a game where red wins.' do
      game = Game.new

      allow($stdin).to receive(:gets).and_return('1', '2', '3', '4', '5', '6', '7',
                                                 '2', '1', '4', '3', '6', '5', '7',
                                                 '2', '1', '3', '5', '4', '7', '6',
                                                 '2', '3')
      expect(game.play).to eql('Player Red has won the game.')
    end

    it 'Plays a game where yellow wins.' do
      game = Game.new

      allow($stdin).to receive(:gets).and_return('1', '2', '3', '4', '5', '6', '7',
                                                 '2', '1', '4', '3', '6', '5', '7',
                                                 '2', '1', '3', '5', '4', '7', '6',
                                                 '3', '1', '3', '7', '4')
      expect(game.play).to eql('Player Yellow has won the game.')
    end
  end
end