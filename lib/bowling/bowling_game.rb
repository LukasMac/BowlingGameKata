class BowlingGame
	def initialize
		@score = 0
		@rolls = Array.new(0)
	end

	def roll(pins)
		@rolls << pins

		# If strike, then there is no second roll
		@rolls << 0 if pins == 10
	end

	def get_frame_score(frame_nr)
		return 0 unless frame_nr.between?(1, 10)

		first_roll_nr  = (frame_nr - 1) * 2
		second_roll_nr = first_roll_nr + 1

		first_roll_points  = @rolls[first_roll_nr]  || 0
		second_roll_points = @rolls[second_roll_nr] || 0

		first_roll_points + second_roll_points
	end

	def is_strike?(frame_nr)
		first_frame_roll_nr = frame_nr * 2 - 1

		@rolls[first_frame_roll_nr] == 10
	end

	def is_spare?(frame_nr)
		get_frame_score(frame_nr) == 10
	end

 	def score
 		(1..10).each do |frame_nr|
 			frame_score = get_frame_score(frame_nr)
 			
			@score += frame_score

 			if is_strike?(frame_nr)
 				@score += get_frame_score(frame_nr + 1)
 			elsif is_spare?(frame_nr)
 				@score += @rolls[frame_nr * 2 - 1]
 			end
 		end

 		@score
 	end
end