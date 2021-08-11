require_relative "00_tree_node"

class KnightPathFinder

    DELTAS = [[-2, 1], [-2, 1], [-1, -2], [-1, 2], [2, 1], [2, -1],
            [1, 2], [1, -2]]

    attr_reader :current_pos

    def initialize(start_pos)
        @current_pos = start_pos
        @root = PolyTreeNode.new(start_pos)
        @moves = {}
        @visited_positions = [start_pos]
    end

    def build_move_tree
        new_moves = new_moves_positions(@current_pos)
        new_moves.each do |move|
            @moves[move] = @root
        end

        until new_moves.empty?
            current_move = PolyTreeNode.new(new_moves.shift)
            current_move.parent = @moves[current_move.value]
            next_moves = new_moves_positions(current_move.value)

            next_moves.each {|next_move| @moves[next_move] = current_move}

            new_moves.concat(next_moves)
        end

        @root

    end

    def new_moves_positions(pos)

        new_moves = valid_positions(pos).reject {|el| @visited_positions.include?(el)}
        
        new_moves.each do |el|
            @visited_positions << el unless @visited_positions.include?(el)
        end
        
        new_moves
    end

    def valid_positions(pos)
        row, col = pos
        DELTAS.map do |deltas|
            x, y = deltas
            if (row + x).between?(0, 7) && (col + y).between?(0, 7)
                [row + x, col + y]
            end
        end.reject(&:nil?)
     
    end


end



