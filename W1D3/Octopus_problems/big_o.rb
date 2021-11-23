
#Sluggish Octopus
#Find the longest fish in O(n^2) time. Do this by comparing all fish lengths to all other fish lengths

# Quadratic time O(n^2) (Horrible way)
def sluggis_octopus(fishes)

    fishes.each_with_index do |fish, i|
        max_length = true 
        fishes.each_with_index do |fish2, i2|
            next if i == i2 
            max_length = false if fish2.length > fish.length
        end

        return fish if max_length
    end

end
        
# p sluggis_octopus(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])



#Dominant Octopus
#Find the longest fish in O(n log n) time. Hint: Merge_sort
class Array
    def merge_sort(&prc)
        prc ||= Proc.new {|x, y| x <=> y }

        return self if count <= 1
        mid_point = count / 2 
        sorted_left = self.take(mid_point).merge_sort(&prc)
        sorted_right = self.drop(mid_point).merge_sort(&prc)
    
        Array.merge(sorted_left, sorted_right, &prc)
    end


    private
    def self.merge(left, right, &prc)

        merged = []

        until left.empty? || right.empty?
         case prc.call(left.first, right.first)
         when -1
            merged << left.shift
         when 0 
            merged << left.shift
         when 1
            merged << right.shift
         end
        end

        merged.concat(left)
        merged.concat(right)

        merged
    end

end

def nlogn_biggest_fish(fishes)
    # sort the array longest to shortest
    prc = Proc.new { |x, y| y.length <=> x.length }
    #return the first element
    fishes.merge_sort(&prc)[0]
end

p nlogn_biggest_fish(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])


#Smart Octopus
#Linear search O(n)
def linear_biggest_fish(fishes)
biggest_fish = fishes.first
    fishes.each do |fish|
        if fish.length > biggest_fish.length
            biggest_fish = fish
        end
    end
    biggest_fish
end

# p linear_biggest_fish(['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh'])


# linear octopus dance O(n)
tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

def slow_dance(direction, tiles_array)
    tiles_array.each_with_index do |tile, index|
        return index if tile == direction
    end
end


#constant time O(1)
 tiles_hash = {
    "up" => 0,
    "right-up" => 1,
    "right"=> 2,
    "right-down" => 3,
    "down" => 4,
    "left-down" => 5,
    "left" => 6,
    "left-up" => 7
}

def fast_dance(direction, tiles_hash)
    tiles_hash[direction]
end

# p fast_dance("right-up", tiles_hash)





# merge_sort([38, 27, 43, 3])












Dog.destroy_all
dog1 = Dog.create(name: "Cliff")
dog2 = Dog.create(name: "Snoopy")

Toys.destroy_all
toy1 = Toys.create(name: "big_bone", color: "white", dog_id: dog1.id)
toy2 = Toys.create(name: "towel", color: "greem", dog_id: dog2.id)
toy3 = Toys.create(name: "dog_house", color: "red", dog_id: dog1.id)
toy4 = Toys.create(name: "blanket", color: "red", dog_id: dog2.id)


def change
    create_table :houses do |t|
      t.string :name, null: false
    end
  end

    def change
    add_column :toys, :dog_id, :integer, null: false
    add_column :toys, :color, :string, null: false
  end

    def change
    create_table :toys do |t|
      t.string :name, null: false
    end
  end

    def change
    create_table :dogs do |t|
      t.string :name, null: false
    end
  end


class Toys < ApplicationRecord

    belongs_to(:dogs, {
        primary_key: :id,
        foreign_key: :dog_id,
        class_name: :Dog
    })

    has_one(:houses, {
        through: :dogs,
        source: :houses
    })

end



class House < ApplicationRecord

    has_many(:dogs, {
        primary_key: :id,
        foreign_key: :house_id,
        class_name: :Dog
    })


    has_many(:toys, {
        through: :dogs,
        source: :toys
    })


end



class Dog < ApplicationRecord
    validates :name, presence: true 
    validate :check_name_length

    def check_name_length
        unless self.name.length >= 2
            errors[:name] << "too short has to be greater than or equl to 2"
        end
    end

    belongs_to(:houses, {
        primary_key: :id,
        foreign_key: :house_id,
        class_name: :House
    })

    has_many(:toys, {
        primary_key: :id,
        foreign_key: :dog_id,
        class_name: :Toys
    })

end


gem 'pry-rails'
  gem 'annotate'




  bundle exec rails db:create 

  bundle exec rails g migration createDog

  bundle exec rails g migration addDogIdToToys

  ps -ef | grep postgres 
  kill -9 #                      

   bundle exec rails g migration addDogIdToToys