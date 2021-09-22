require 'byebug'
# Time O(n^2) Quadratic 
# Space O(1) Constant 
def bad_two_sum?(arr, target_sum)
    arr.length.times do |i|
        (arr.length - i - 1).times do |j|
            return true if arr[i] + arr[j + i  + 1] == target_sum
        end
    end
    false
end

# arr = [0, 1, 5, 7]
# bad_two_sum?(arr, 6)
#bad_two_sum?(arr, 10)


#O(nlogn) linearithmic time
#O(n) linear space
def okay_two_sum_a?(arr, target_sum)  
debugger
arr.sort #does this make the function run linearithimic time?
i, j = 0, arr.length - 1

while i < j 
    case (arr[i] + arr[j]) <=> target_sum
        when 0
            return true
        when -1 
             i += 1
        when 1
            j -= 1
        end
    end
    false
end

# arr = [0, 1, 5, 7]
# okay_two_sum_a?(arr, 6)
# okay_two_sum_a?(arr, 10)


#O(n) linear time
#O(n) linear space
def two_sum?(arr, target_sum)
    # debugger

    complements = {}

    arr.each do |num|
       return true if complements[target_sum - num]
         complements[num] = true
         p complements
    end
    false
end

# arr = [0, 1, 5, 7]
arr1 = [0, 1, 2, -2]

# two_sum?(arr, 6) # => should be true
#two_sum?(arr, 10) # => should be false
two_sum?(arr1, 0)


# 6 - 0  6 0 - true
# 6 - 1  5 1 = true
# 6 - 5  1 
# 6 - 7 -1 

# 10 - 0 10 0 - true
# 10 - 1 9  1 - true
# 10 - 5 5  5 - true
# 10 - 7 3  3 - true




