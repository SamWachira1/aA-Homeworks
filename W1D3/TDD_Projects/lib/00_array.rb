def my_uniq(array)
    array.uniq
end


def two_sum(array)

   pairs = []

   array.count.times do |i1|
    (i1 + 1).upto(array.count - 1) do |i2|
        pairs << [i1, i2] if array[i1] + array[i2] == 0 
        end
    end

    pairs 

end

# print n = two_sum([2, -2, 1, 5, -4])






