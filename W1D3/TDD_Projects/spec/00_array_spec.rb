require 'rspec'
require '00_array'

    describe "#my_uniq" do 
      let (:array) { [1, 3, 4, 1, 3, 7] }
      let (:uniq_array) {my_uniq(array.dup)}

        it "removes duplicates" do
            array.each do |item|
            expect(uniq_array.count(item)).to eq(1)
            end
        end

        it "only contains items from original array" do
           uniq_array.each do |item| 
            expect(array).to include(item)
           end
        end

        it "does not modify original array" do
            expect{my_uniq(array)}.to_not change{array}
        end        

    end

    describe "#two_sum" do 
        let(:array) {[2, -2, 1, 5, -4]}
        let(:one_zero) {[1, 0, 3]}
        let(:two_zero) {[2,3,4,0,0]}

        it "finds the two_sum" do
            expect(two_sum(array)).to eq([[0,1]])
        end

        it "doesn't confuse one zero" do
            expect(two_sum(one_zero)).to eq([])
        end

        it "handles two zeros" do 
            expect(two_sum(two_zero)).to eq([[3, 4]])
        end
    end


    describe "#my_transpose" do
        it "transposes a matrix" do
            matrix = [
                [1, 2, 3],
                [4, 5, 6],
                [7, 8, 9]
            ]
            expect(my_transpose(matrix)).to eq([
                [1, 4, 7],
                [2, 5, 8],
                [3, 6, 9]
            ])
        end
    end

    describe "#stock_picker" do
        it "finds a simple pair" do
            expect(stock_picker([3, 1, 0, 4, 6, 9])).to eq([4, 5])
        end

        it "finds a better pair after an inferior pair" do
            expect(stock_picker([9,6,3,0,7])).to eq([3,4])
        end

        it "does not buy stocks in a crash" do
            expect(stock_picker([5,4,3,2,1])).to be_nil
        end
    end

















