require_relative "piece"
require_relative "./modules/stepable_pieces"

class King < Piece 
    include SteppingPiece

    def symbol
    '♚'.colorize(color)   
    end

    protected

    def move_diffs
     [[-1, -1],
     [-1, 0],
     [-1, 1],
     [0, -1],
     [0, 1],
     [1, -1],
     [1, 0],
     [1, 1]]
    end



end
