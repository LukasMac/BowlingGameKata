require 'spec_helper'

module BowlingGame
	
	describe Game do

		def roll_many(rolls_count, pins)
			rolls_count.times do
				@bowling_game.roll(pins)
			end
		end

		before(:each) do
		  @bowling_game = Game.new
		end

		it "should return score 1 for roll with one knocked pin" do
	  	@bowling_game.roll(1)

	  	@bowling_game.score.should == 1
		end
	  
		it "should return score 2 for two rolls with one knocked pin" do
		  roll_many(2, 1)

		  @bowling_game.score.should == 2		  
		end

		it "should return score 20 for many rolls with 1 knocked pin" do
		  roll_many(20, 1)

		  @bowling_game.score.should == 20
		end

		context "after spare roll" do
		  
			before(:each) do
			  @bowling_game.roll(1)
			  @bowling_game.roll(9)
			end

			it "should add next roll's points as a bonus" do
			  @bowling_game.roll(1)

			  # spare = 10 points plus next roll bonus = 1, and plus next roll points = 1 total 12
			  @bowling_game.score.should == 12
			end

			it "should add next roll's points as a bonus (2)" do
			  @bowling_game.roll(5)
			  @bowling_game.roll(1)

			  @bowling_game.score.should == 21
			end

			it "should add next roll's points as a bonus (3)" do
			  @bowling_game.roll(0)
			  @bowling_game.roll(1)

			  @bowling_game.score.should == 11
			end
		end

		context "after strike roll" do
			before(:each) do
			  @bowling_game.roll(10)
			end

			it "should add next two rolls' points as a bonus" do
			  @bowling_game.roll(1)
			  @bowling_game.roll(1)

			  @bowling_game.score.should == 14
			end
		  
			it "should add next two rolls' points as a bonus (2)" do
			  @bowling_game.roll(1)
			  @bowling_game.roll(2)

			  @bowling_game.score.should == 16
			end
 
			it "should add next two rolls' points as a bonus (3)" do
			  @bowling_game.roll(0)
			  @bowling_game.roll(1)

			  @bowling_game.score.should == 12
			end

			it "should add next two rolls' points as a bonus (4)" do
			  @bowling_game.roll(0)
			  @bowling_game.roll(0)

			  @bowling_game.score.should == 10
			end
		end

	end

end