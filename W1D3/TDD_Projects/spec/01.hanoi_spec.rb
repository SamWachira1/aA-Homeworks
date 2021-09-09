require "./lib/01.hanoi.rb"
require 'rspec'

describe TowersOfHanoi do
    subject(:towers) {TowersOfHanoi.new}

    describe "#render" do 
        it "pretty-prints stacks" do
            expect(towers.render).to eq("Tower 0:  3  2  1\nTower 1:  \nTower 2:  \n")
        end

        it "prints shorter stacks" do
            towers.move(0, 2)
            towers.move(0, 1)
            expect(towers.render).to eq("Tower 0:  3\nTower 1:  2\nTower 2:  1\n")
        end
    end

    describe "#move" do

        it "allows moving to blank space" do 
            expect {towers.move(0, 1)}.not_to raise_error
        end

        it "allows moving to larger disk" do
            towers.move(0, 2)
            towers.move(0, 1)
            expect{towers.move(2, 1)}.not_to raise_error
        end

        it "does not allow moving from an empty stack" do
            expect {towers.move(1, 2)}.to raise_error("cannot move an empty stack")
        end

        it "does not allow moving to smaller stack" do
            towers.move(0, 1)
            expect{towers.move(0, 1)}.to raise_error("cannot move to smaller disk")
        end

    end

    describe "#won" do 

        it "has not won at the start of game" do
            expect(towers).not_to be_won
        end

        it "has won when all the stacks are in tower 1" do
            towers.move(0, 1)
            towers.move(0, 2)
            towers.move(1, 2)
            towers.move(0, 1)
            towers.move(2, 0)
            towers.move(2, 1)
            towers.move(0, 1)

            expect(towers).to be_won
        end

        it "has won when all the stacks are in tower 2" do
            towers.move(0, 2)
            towers.move(0, 1)
            towers.move(2, 1)
            towers.move(0, 2)
            towers.move(1, 0)
            towers.move(1, 2)
            towers.move(0, 2)

            expect(towers).to be_won
        end
    end
end
