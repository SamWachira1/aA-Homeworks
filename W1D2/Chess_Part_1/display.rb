require_relative "board"
require_relative "cursor"
require "colorize"

class Display

    attr_reader :cursor, :board, :selected
    def initialize(board, cursor = true)
        @board = Board.new
        @cursor = Cursor.new([0,0], board)
        @selected = {}
    end

    def build_display_grid
        @board.rows.map.with_index do |row, i|
            build_row(row, i)
        end
    end

    def build_row(row, i)
        row.map.with_index do |piece, j|
            color = set_color(i, j)
            piece.to_s.colorize(color)
        end
    end

    def render
        system "clear"
        puts "Navigate using WASD or arrow keys."
        build_display_grid.each {|row| row.join("") }

         selected.each do |_k, v|
            puts v
        end

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

    def set_color(i, j)

        if cursor.cursor_pos == [i, j] && cursor.selected
            bg = :green
        elsif cursor.cursor_pos == [i ,j]
            bg = :light_yellow
        elsif (i.even? && j.odd?) || (i.odd? && j.even?)
            bg = :light_blue
        else 
            bg = :white
        end
        { background: bg}
        end
    end


p test = Display.new(self).render