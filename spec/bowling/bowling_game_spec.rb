require 'spec_helper'

module BowlingGameSpec
	
	describe BowlingGame do

		before(:each) do
		  @bowling_game = BowlingGame.new
		end

		it "should return score 1 for roll with one knocked pin" do
	  	@bowling_game.roll(1)

	  	@bowling_game.score.should == 1
		end
	  
		it "should return score 2 for two rolls with one knocked pin" do
		  @bowling_game.roll(1)
		  @bowling_game.roll(1)

		  @bowling_game.score.should == 2		  
		end

		context "after spare roll" do
		  
			before(:each) do
			  @bowling_game.roll(1)
			  @bowling_game.roll(9)
			end

			it "should add next roll's points as a bonus" do
			  @bowling_game.roll(1)

			  # spare = 10 points plus next roll bonus = 1, and plus next roll points = 1  == 12
			  @bowling_game.score.should == 12
			end

			it "should add next roll's points as a bonus" do
			  @bowling_game.roll(2)

			  @bowling_game.score.should == 14		  
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
		  
		end

	end

end