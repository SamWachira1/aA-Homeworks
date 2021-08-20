class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2 
    @cups = Array.new(14) {Array.new}

    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index do |cup, indx|
      next if indx == 6 || indx == 13
      4.times do 
        cup << :stone
      end
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos < 0 || start_pos > 12
    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []

    cups_indx = start_pos
    until stones.empty?
      cups_indx += 1
      cups_indx = 0 if cups_indx > 13 #why do we do this?
      if cups_indx == 6
        @cups[6] << stones.pop if current_player_name == @name1
      elsif cups_indx == 13
        @cups[13] << stones.pop if current_player_name == @name2
      else  
        @cups[cups_indx] << stones.pop
      end
    end

    render
    next_turn(cups_indx)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
     if ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
     elsif @cups[ending_cup_idx].count == 1
      :switch
     else
     ending_cup_idx
     end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups.take(6).all? {|cup| cup.empty?} ||
    @cups[7..12].all? {|cup| cup.empty?}
  end

  def winner
    player_1 = @cups[6].count
    player_2 = @cups[13].count

    if player_1 == player_2
      :draw
    else
      player_1 > player_2 ? @name1 : @name2
    end
 
  end


end
