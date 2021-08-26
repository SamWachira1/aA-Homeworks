require_relative "piece"
require_relative "./modules/sliding_pieces"

class Bishop < Piece
  include Slideable

   def symbol
     '♝'.colorize(color)
   end

    protected 

    def move_dirs
        linear
    end


end
