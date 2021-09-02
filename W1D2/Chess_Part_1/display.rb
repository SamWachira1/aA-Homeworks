require "colorize"
require_relative "cursor"

class Display

    attr_reader :board, :selected, :cursor

    def initialize(board)
        @board = board
        @cursor = Cursor.new([0,0], board)
        @selected = {}
    end

    def build_grid
        @board.rows.map.with_index do |row, i|
            build_row(row, i)
        end
    end

    def build_row(row, i)
        row.map.with_index do |piece, j|
            color = colors_for(i, j)
            piece.to_s.colorize(color)
        end
    end

    def colors_for(i, j)
        if cursor.cursor_pos == [i, j] && cursor.selected
            bg = :green
        elsif cursor.cursor_pos == [i ,j]
            bg = :light_red
        elsif (i + j).odd?
            bg = :light_blue
        else 
            bg = :light_yellow
        end
        { background: bg}
    end

  def reset!
    @selected.delete(:error)
  end

  def uncheck!
    @selected.delete(:check)
  end

  def set_check!
    @selected[:check] = "Check!"
  end

    def render
        system "clear"
        puts "Navigate using WASD or arrow keys."
        build_grid.each {|row| puts row.join() }

            @selected.each do |_key, val|
            puts val
        end
    end
end


 

# p test = Display.new(self)