require_relative 'player'
require_relative 'deck'

class Game
    attr_reader :players, :pot, :deck

    def initialize
        @players = []
        @pot = 0
        @deck = Deck.new
    end

    def add_players(n, buying_amount)
        n.times {@players << Player.buy_in(buying_amount)}
    end

    def game_over?
        players.count {|player| player.bankroll > 0 } <= 1
    end

    def deal_cards
        players.each do |player|
            next if player.bankroll <= 0
            player.deal_in(deck.deal_hand)
        end
    end

    def add_to_pot(amount)
        @pot += amount
        amount 
    end

end
