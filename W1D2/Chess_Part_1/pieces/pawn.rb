require_relative "piece"

class Pawn < Piece

    def symbol
      '♟'.colorize(color)
    end

    def moves
        forward_step + side_attacks
    end

    private

    def at_start_row
        pos[0] == (color == :white) ? 6 : 1
    end

    def forward_dir
        color == :white ? -1 : 1
    end


    def forward_step
        i, j = pos
        one_step = [i + forward_dir,  j]
        return [] unless board.in_bound?(one_step) && board.empty?(one_step)

        steps = [one_step]
        two_steps = [i + 2 * forward_dir, j]
        steps << two_steps if at_start_row && board.empty?(two_steps)
        steps
    
    end

    def side_attacks
        i, j = pos
        side_moves = [[i + forward_dir, j - 1]], [[i + forward_dir, j + 1]]
        
        side_moves.select do |new_pos|
            next false unless board.in_bound?(new_pos) 
            next false if board.empty?(new_pos)

            threatened_pos = board[new_pos]
            threatened_pos + threatened_pos.color != color
        end
    end

end

