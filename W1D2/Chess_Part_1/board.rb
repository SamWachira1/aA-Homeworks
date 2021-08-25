require_relative "pieces"

class Board
 
    attr_reader :rows, :null
    def initialize
        @rows = rows
        populate_board
    end

    def populate_board
        @null = null
        null = NullPiece.instance
        rows = Array.new(8) {Array.new(8, null)}
    end



end
