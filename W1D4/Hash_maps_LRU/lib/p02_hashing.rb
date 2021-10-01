class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    each_with_index.inject(0) do |intermediate_hash, (el, i)|
      (el.hash + i.hash) ^ intermediate_hash
    end
  end
end

# arr = [1,"Sam",3,4,5,6]
# p arr.hash



class String
  def hash
    chars.map(&:ord).hash
  end
end

# str = "hello my name is james"
# p str.hash

class Hash
  def hash
  to_a.sort_by(&:hash).hash
  end
end

h = {:foo => 0, "Sam" => 1,  "class"=>  [3, 2, 1] }
p h.hash
