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

