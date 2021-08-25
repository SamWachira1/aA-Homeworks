require "colorize"

class Piece
    attr_reader :board, :color
    attr_accessor :pos
    def initialize(color, board, pos)
        @color = color
        @board = board 
        @pos = pos
    end

    def to_s
        symbol
    end

    def valid_moves
        moves.select do |pos|
            board.in_bounds?(pos) &&
            (board.is_null?(pos)) || board[pos].color != color
        end
    end



end
