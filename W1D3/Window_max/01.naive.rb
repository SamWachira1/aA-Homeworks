#Phase 1
# O(n * m)
def windowed_max_range(array, window_size)

    num_windows = array.length - window_size + 1 
    
    current_max_range = nil

        num_windows.times do |i| #1st
    
        windows = array.slice(i, window_size ) #2nd
    
        current_range = windows.max - windows.min #these are running in O(n^2)

        current_max_range = current_range if !current_max_range || current_range > current_max_range
    end

    current_max_range
end


# p windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
  windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8
