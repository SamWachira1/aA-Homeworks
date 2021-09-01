require_relative "piece"
require "sliding_pieces"

class Bishop < Piece
  include Slideable

   def symbol
     '♝'.colorize(color)
   end

    protected 

    def move_dirs
        diag
    end


end
