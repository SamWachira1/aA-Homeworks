require_relative "piece"
require_relative "sliding_pieces"

class Rook < Piece
    include Slideable
    
    def symbol
        '♜'.colorize(color)
    end

    protected 

    def move_dirs
     horizontal_and_vertical_dirs
    end



end
