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

    def [](pos)
        row, col = pos
        rows[row][col]
    end

    def []=(pos, piece)
        row, col = pos
        rows[row][col] = piece

    end







end
