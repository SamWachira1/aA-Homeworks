require 'io/console'
require 'benchmark'


class SortingDemo

    #Bubble_sort O(n^2)
    def self.bubble_sort!(array)
        len = (array.length - 1)
        sorted = false 

        until sorted
        sorted = true 
        (0...len).each do |idx|
            if array[idx] > array[idx + 1]
             array[idx], array[idx + 1] = array[idx + 1], array[idx]
             sorted = false
            end
          end 
        end

        array
    end

    def self.bubble_sort(array)
        bubble_sort!(array.dup)
    end

    # Merge Sort: O(n*lg(n)) / recursively 
    def self.merge_sort(arr, &prc)
        return arr if arr.length <= 1

        mid_indx = arr.size / 2

        merge(
            merge_sort(arr.take(mid_indx), &prc),
            merge_sort(arr.drop(mid_indx, &prc)),
            &prc
        )
    end


    def self.merge(left, right, &prc)
        merged = [] 
        prc = Proc.new {|num, num2| num <=> num2} unless block_given?
        until left.empty? || right.empty?
            case prc.call(left.first, right.first)
            when - 1
                 merged << left.shift 
            when 0 
                 merged << left.shift
            when 1
                merged << right.shift
            end
        end 

        merged + left + right 
    end

    def self.performance_test(size, count)

        arrays_to_test = Array.new(count) {random_arr(size)}

        Benchmark.benchmark(Benchmark::CAPTION, 9, Benchmark::FORMAT,
                            "Avg.Merge:  ", "Avg.BubbleSort: ") do |b|
            merge = b.report("Tot. Merg:  ") {run_merge_sort(arrays_to_test)}
            bubble = b.report("Tot. Buble:  ") {run_bubble_sort(arrays_to_test)}
            [merge/count, bubble/count]
         end

    end

    def self.random_arr(n)
        Array.new(n) {rand(n)}
    end

    def self.run_bubble_sort(arrays)
        arrays.each do |array|
            arrays_to_test = array.dup
            bubble_sort(arrays_to_test)
        end
    end


    def self.run_merge_sort(arrays)
        arrays.each do |array|
            arrays_to_test = array.dup
            merge_sort(arrays_to_test)
        end
    end

    def self.run_performance_test(multiplier = 5, rounds = 3)

        [1, 10, 100, 1000, 10000].each do |size|
            size *= multiplier

            wait_for_keypress(
                "Press any key to benchmark sorts #{size} elements"
            )

            performance_test(size, rounds)
        end
    end

    def self.wait_for_keypress(prompt)
        puts prompt
        STDIN.getch
    end


end

p SortingDemo.run_performance_test