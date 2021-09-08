require "colorize"

class Piece
    attr_reader :board, :color
    attr_accessor :pos
    def initialize(color, board, pos)
        raise "invalid color" unless %i(white black).include?(color)
        raise "invalid_pos" unless board.valid_pos?(pos)

        @color = color
        @board = board
        @pos = pos

        @board.add_piece(self, pos)
    end

    # def valid_pos?(pos)
    #   pos.all? {|coord| coord.between?(0, 7) }
    # end


    def to_s
     " #{symbol} "
    end

    def empty?
        false 
    end

    def symbol
      raise NotImplementedError
    end

    def valid_moves
      moves.reject { |end_pos| move_into_check?(end_pos) }
    end

    private


  def move_into_check?(end_pos)
    test_board = board.dup
    test_board.move_piece!(pos, end_pos)
    test_board.in_check?(color)
  end

end
