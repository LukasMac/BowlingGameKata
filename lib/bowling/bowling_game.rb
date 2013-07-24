class BowlingGame
	MAX_ROLLS = 21
	MAX_FRAMES = 10

	def initialize
		@score = 0
		@rolls = Rolls.new
	end

	def roll(pins)
		@rolls.roll(pins)
	end

	def score
 		(1..10).each do |frame_nr|
 			@score += @rolls.frame_score(frame_nr)
 			
 			if @rolls.is_strike?(frame_nr)
 				@score += @rolls.frame_score(frame_nr + 1)
 			elsif @rolls.is_spare?(frame_nr)
 				next_roll_nr = frame_first_roll_nr(frame_nr + 1)
 				@score += @rolls.get_roll_points(next_roll_nr)
 			end
 		end

 		@score
 	end

 	private

	def frame_first_roll_nr(frame_nr)
		(frame_nr * 2) - 1
	end
end

class Rolls
	MAX_ROLLS = 21
	MAX_FRAMES = 10

	def initialize
		@rolls = []
	end
	
	def roll(pins)
		@rolls << pins

		# If strike, then there is no second roll
		@rolls << 0 if pins == 10
	end

	def get_roll_points(roll_nr)
		return 0 unless roll_nr.between?(1, MAX_ROLLS)

		@rolls[roll_nr-1] || 0
	end

	def frame_score(frame_nr)
		first_roll_nr  = frame_first_roll_nr(frame_nr)
		second_roll_nr = first_roll_nr + 1

		get_roll_points(first_roll_nr) + get_roll_points(second_roll_nr)
	end

	def is_strike?(frame_nr)
		first_frame_roll_nr = frame_first_roll_nr(frame_nr)

		get_roll_points(first_frame_roll_nr) == 10
	end

	def is_spare?(frame_nr)
		frame_score(frame_nr) == 10
	end

	private

	def frame_first_roll_nr(frame_nr)
		(frame_nr * 2) - 1
	end
end