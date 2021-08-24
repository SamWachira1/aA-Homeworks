#PHASE 2

FRUITS = ["apple", "banana", "orange"].freeze

class CoffeeError < StandardError
  def message 
   puts "I honestly cannot have any more coffee"
  end
end

class NotCorrectFruitError < StandardError
  def message
   puts "Yuck, I do not eat that"
  end
end


def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeError
  else
    raise NotCorrectFruitError
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)" 

  begin
  puts "Feed me a fruit! (Enter the name of a fruit:)"
  maybe_fruit = gets.chomp
  reaction(maybe_fruit) 
  rescue CoffeeError => e
    puts e.message
    retry
  rescue NotCorrectFruitError => e
    puts e.message
    retry
  end
end  

# PHASE 3
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    raise ArgumentError.new("cannot leave name empty") if name.empty?
    raise ArgumentError.new("best friendships take time meaning at least 5 years") if yrs_known.to_i < 5
    raise ArgumentError.new("favorite passed time cannot be empty") if fav_pastime.empty?

    @name = name
    @yrs_known = yrs_known.to_i
    @fav_pastime = fav_pastime
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go see #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


