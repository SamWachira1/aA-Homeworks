require_relative "pieces"

class Board
 
    attr_reader :rows, :null
    def initialize(fill_board = true)
       @null = NullPiece.instance
       board = populate_board(fill_board)
       board
    end

    def populate_board(fill_board)
     @rows = Array.new(8) {Array.new(8, null) }
        return unless fill_board
        %i(white black).each do |color|
            fill_back_row(color)
            fill_pawn_row(color)
        end
    end


    def add_piece(piece, pos)
        self[pos] = piece
    end

    def empty?(pos)
        self[pos].empty?
    end

    def fill_pawn_row(color)
        row = (color == :white) ? 6 : 1
        8.times do |col|
            Pawn.new(color, self, [row, col] )
        end
        
    end
    
    def fill_back_row(color)
        back_ranks = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
        row = (color == :white) ? 7 : 0 
        back_ranks.each_with_index do |rank, col|
            rank.new(color, self, [row, col])
        end
    end

    
    def check_mate?(color)
        in_check?(color) && 
        rows.flatten.none? {|pc| pc.color == color && !pc.valid_moves.nil?}
    end

    def in_check?(color)
        other_color = (color == :white) ? :black : :white
        kings_pos = find_king_pos(color)
        get_all_moves(other_color).include?(kings_pos)
    end

    def find_king_pos(color)

        rows.each_with_index do |row, i|
            row.each_with_index do |_, j|
                pc = self[[i,j]]
                return [i, j] if pc.class == King && pc.color == color 
            end
        end
    end

    def get_all_moves(color)
        all_moves = []

        rows.each_with_index do |row, i|
            rows.each_with_index do |_, j|
                pc = self[[i,j]]
                all_moves << pc.valid_moves if pc.color == color && pc.class != Pawn
            end
        end
        all_moves
    end

    def in_bounds?(pos)
        pos.all? { |coord| coord.between?(0, 7) }
    end

    def pieces
        @rows.flatten.reject(&:empty?)
    end

    def is_null?(pos)
        self[pos] == null
    end

    def [](pos)
        row, col = pos
        @rows[row][col]
    end

    def []=(pos, piece)
        row, col = pos
        @rows[row][col] = piece
    end

    def move_piece(color, start_pos, end_pos)

     piece = self[start_pos]
     raise ArgumentError.new("This is not your piece!") if piece.color != color 
     raise ArgumentError.new("There is no piece at starting position.") if piece == nil
     raise ArgumentError.new("You cannot move piece there") if !piece.valid_moves.include?(pos)

     self[start_pos] = null
     self[end_pos] = piece
     piece.pos = end_pos

    end










end
