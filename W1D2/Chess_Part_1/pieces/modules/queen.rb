require_relative "piece"
require_relative "./modules/sliding_pieces"

class Queen < Piece
    include Slideable
    
    def symbol
        '♛'.colorize(color)
    end

    protected 

    def move_dirs
        diag + linear
    end



end
