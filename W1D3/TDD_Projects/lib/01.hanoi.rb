
class TowersOfHanoi

    def initialize
        @stacks = [[3,2,1], [], []]
    end

    def render
      'Tower 0:  ' + @stacks[0].join('  ') + "\n" +
      'Tower 1:  ' + @stacks[1].join('  ') + "\n" +
      'Tower 2:  ' + @stacks[2].join('  ') + "\n"
    end

    def display
        # this moves everything up in the console so that whatever we print
        # afterwards appears at the top
        system('clear')
        puts render
    end

    def move(from_tower, to_tower)
        raise "cannot move an empty stack" if @stacks[from_tower].empty?
        raise "cannot move to smaller disk" unless valid_move?(from_tower, to_tower)

        @stacks[to_tower] << @stacks[from_tower].pop

    end

    def valid_move?(from_tower, to_tower)
        return false unless [from_tower, to_tower].all? {|i| i.between?(0, 2)}
    

        !@stacks[from_tower].empty? && (
        @stacks[to_tower].empty? ||
        @stacks[to_tower].last > @stacks[from_tower].last
        )
    end

    def won?
        @stacks[0].empty? && @stacks[1..2].any?(&:empty?)
    end











end


