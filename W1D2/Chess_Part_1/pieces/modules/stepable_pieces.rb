module SteppingPiece

    def moves
        possible_moves = []
        move_diff.each do |diff|
            dx, dy = diff
            possible_moves.concat(generate_moves(dx, dy))
        end

        possible_moves
    end

    def generate_moves(dx, dy)
        [[@pos[0] + dx, @pos[1] + dy]]
    end






