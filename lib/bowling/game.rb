module BowlingGame

	class Game
		def initialize
			@rolls = Rolls.new
		end

		def roll(pins)
			@rolls.roll(pins)
		end

		def score
	 		@rolls.to_frames.total_score
	 	end
	end
	
end