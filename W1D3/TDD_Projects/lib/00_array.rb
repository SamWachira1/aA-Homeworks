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

    def my_transpose(matrix)
        matrix.transpose
    end

    def stock_picker(prices)

        best_pair = nil
        best_profit = 0

        prices.each_index do |buy_date|
            prices.each_index do |sell_date|
                next if sell_date < buy_date

                profit = prices[sell_date] - prices[buy_date]
                if profit > best_profit
                    best_pair = [buy_date, sell_date]
                    profit = best_profit
                end
            end
        end
        best_pair
    end













