# O(n!) combinatorial time
# O(n!) combintorial space
#worst solution if you increase the size of the strings it will have a longer run time
def first_anagram?(str, str2)
    all_anagrams(str).include?(str2)
end

def all_anagrams(string)
    return [string] if string.length <= 1
    prev_anagram = all_anagrams(string[0...-1])
    new_anagram = []

    prev_anagram.each do |anagram|
        (0..anagram.length).each do |i|
            new_anagram << anagram.dup.insert(i, string[-1])
        end
    end
    new_anagram
end

# p first_anagram?("gizmo", "sally")
# p first_anagram?("elvis", "lives") 


# Phase II:
# O(n^2) Quadratic Time
# O(n) Linear space
def second_anagram?(str, str2)
    arr1, arr2, = str.split(""), str2.split("")

    arr1.each do |letter|
        target_indx = arr2.find_index(letter)
        return false unless target_indx
        arr2.delete_at(target_indx)
    end

    arr2.empty?
end

# p second_anagram?("gizmo", "sally")    #=> false
# p second_anagram?("elvis", "lives")    #=> true



# Phase III:
# O(n*log(n)) linearithmic time
# O(n) linear space
def third_anagram?(str1, str2)

    sorted_strings = [str1, str2].map do |str|
         str.split("").sort.join
    end

    sorted_strings.first == sorted_strings.last
end

#  third_anagram?("gizmo", "sally")    #=> false
#  third_anagram?("elvis", "lives")    #=> true


# Phase IV:

# O(n) linear time
# O(1) constant space
def fourth_anagram?(str1, str2)
    letter_counts1 = Hash.new(0)
    letter_counts2 = Hash.new(0)

    str1.each_char {|letter| letter_counts1[letter] += 1}
    str2.each_char {|letter| letter_counts2[letter] += 1}

    letter_counts1 == letter_counts2

end

#  p fourth_anagram?("gizmo", "sally")    #=> false
#  p fourth_anagram?("elvis", "lives")    #=> true


 #Bonus (Using one hash only)

 def fourth_anagram_one_hash(str1, str2)

    letter_sums = Hash.new(0)
    str1.each_char {|letter|  letter_sums[letter] += 1}
    str2.each_char {|letter| letter_sums[letter] -= 1}


    letter_sums.each_value.all? {|sum| sum == 0}

 end

 p fourth_anagram_one_hash("gizmo", "sally")    #=> false
 p fourth_anagram_one_hash("elvis", "lives")    #=> true




