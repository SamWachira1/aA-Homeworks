require 'byebug'
#Phase 1
# First, write a function that compares each element to every other element of the list.
# Return the element if all other elements in the array are larger.
# What is the time complexity for this function

# list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
#O(n^2) quadratic time 
# 0(n^2) quadratic space
def my_min(list)
    min_num = nil

    list.each do |num|
        dup_list = list.dup
        dup_list.delete(num)
        min_num = num if dup_list.all?{|num2| num2 > num}
    end
    min_num
end


# p my_min([ 0, 3, 5, 4, -5, 10, 1, 90 ])  # =>  -5

#Phase 2
# Now rewrite the function to iterate through the list just once while keeping track of the minimum. 
# What is the time complexity?

#O(n) time
#O(1) space
def my_min1b(list)

    min_num = list.first
    list.each {|num| min_num = num if num < min_num}
    min_num

end

# p my_min1b([ 0, 3, 5, 4, -5, 10, 1, 90 ])  # =>  -5

#Largest Contigious Sub_sum
#You have an array of integers and you want to find the largest contiguous (together in sequence) sub-sum. Find the sums of all contiguous sub-arrays and return the max.

# O(n^3) time
# O(n^3) space
def largest_contiguous_subsum(list)

    sub_arr = []
    list.each_index do |indx|
        (indx..list.length - 1).each do |indx2|
          sub_arr << list[indx..indx2]
        end
    end
    sub_arr.map { |subs| subs.inject(:+) }
end


# p largest_contiguous_subsum([5, 3, -7])


#Phase 2
# Write a new function using O(n) time with O(1) memory. Keep a running tally of the largest sum. To accomplish this efficient space complexity, consider using two variables. One variable should track the largest sum so far and another to track the current sum. 

# O(n) time
# O(1) space
def largest_contiguous_subsum2(arr)
    largest = arr[0]
    current = arr[0]

    (1..arr.length - 1).each do |i|
     current = 0 if current < 0 
     current += arr[i]

     largest = current if current > largest
    end
    largest
end

largest_contiguous_subsum2([5, -7, 3])










