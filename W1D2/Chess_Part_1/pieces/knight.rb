require_relative "piece"
require_relative "stepable_pieces"

class Knight < Piece 
    include SteppingPiece

    def symbol
     '♞'.colorize(color)
    end

    protected

    def move_diffs
     [[-2, -1],
     [-1, -2],
     [-2, 1],
     [-1, 2],
     [1, -2],
     [2, -1],
     [1, 2],
     [2, 1]]
    end


end
