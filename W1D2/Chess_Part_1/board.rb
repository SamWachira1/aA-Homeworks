require_relative "pieces"

class Board 
 
    attr_reader :rows

    def initialize(fill_board = true)
       @null = NullPiece.instance
       board = populate_board(fill_board)
       board
    end

    def [](pos)
        row, col = pos
        @rows[row][col]
    end

    def []=(pos, piece)
        row, col = pos
        @rows[row][col] = piece
    end

    def add_piece(piece, pos)
        self[pos] = piece
    end

    def check_mate?(color)
        return false unless in_check?(color) 

        pieces.select {|p| p.color == color}.all? do |piece|
            piece.valid_moves.empty?
        end
    end

    def dup
        new_board = Board.new(false)
         pieces.each do |piece|
            piece.class.new(piece.color, new_board, piece.pos)
         end
         new_board
    end


    def empty?(pos)
        self[pos].empty?
    end

    def in_check?(color)
       king_pos = find_king_pos(color).pos

       pieces.any?  do |p|
        p.color != color && p.moves.include?(king_pos)
       end
    end


    def move_piece(turn_color, start_pos, end_pos)
        raise "start position is empty" if empty?(start_pos)

        piece = self[start_pos]

        if piece.color != turn_color
            raise 'Your must move your own piece'
        elsif !piece.moves.include?(end_pos)
            raise " Piece does not move like that"
        elsif !piece.valid_moves.include?(end_pos)
            raise "You cannot move into check"
        end
        move_piece!(start_pos, end_pos)
    end


    def move_piece!(start_pos, end_pos)
        piece = self[start_pos]
        raise 'piece cannot move like that' unless piece.moves.include?(end_pos)

        self[end_pos] = piece
        self[start_pos] = @null
        piece.pos = end_pos

        nil
       
    end


     def pieces
        @rows.flatten.reject(&:empty?)
    end

    def valid_pos?(pos)
       puts  pos.all? {|coord| coord.between?(0, 7) }
    end


    private 

    attr_reader :null

    def fill_back_row(color)
        back_ranks = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        row = (color == :white) ? 0 : 7
        back_ranks.each_with_index do |rank, col|
            rank.new(color, self, [row, col])
        end
    end

    def fill_pawn_row(color)
        row = (color == :white) ? 6 : 1
        8.times do |col|
            Pawn.new(color, self, [row, col] )
        end
    end

    def find_king_pos(color)
        king_pos = pieces.find {|p| p.color == color && p.is_a?(King)}
        king_pos || (raise "king not found")
    end

    def populate_board(fill_board)
     @rows = Array.new(8) {Array.new(8, @null) }
        return unless fill_board
        %i(white black).each do |color|
            fill_back_row(color)
            fill_pawn_row(color)
        end
    end



end

