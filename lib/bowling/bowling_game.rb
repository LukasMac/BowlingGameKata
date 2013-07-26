class BowlingGame
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

class Frames
	MAX_FRAMES = 10

	class Frame
		def initialize(first_4_rolls, is_last_frame = false)
			@rolls = first_4_rolls || []
			@is_last_frame = is_last_frame
		end

		def roll_points(roll_index)
			@rolls[roll_index-1] || 0
		end

		def first_roll
			roll_points(1)
		end

		def second_roll
			roll_points(2)
		end

		def is_strike?
			first_roll == 10
		end

		def is_spare?
			((first_roll + second_roll) == 10) && (not is_strike?)
		end

		def frame_score
			return @rolls[0,3].inject(0, :+) if @is_last_frame

			score = first_roll + second_roll

			if is_spare?
				score += roll_points(3)
			elsif is_strike?
				score += roll_points(3) + roll_points(4)
			end

			score
		end

		alias_method :score, :frame_score
	end

	def initialize(rolls)
		@rolls = rolls
	end

	def frame(frame_index)
		first_roll_index  = (frame_index - 1) * 2

		is_last_frame = frame_index == MAX_FRAMES

		Frame.new(@rolls[first_roll_index, 4], is_last_frame)
	end

	def each
		MAX_FRAMES.times do |index|
			yield frame(index + 1)
		end
	end

	def total_score
		score = 0

		MAX_FRAMES.times do |index|
			score += frame(index + 1).score
		end

		score
	end
end

class Rolls
	MAX_ROLLS = 21

	def initialize
		@rolls = []
	end
	
	def roll(pins)
		@rolls << pins

		# If strike, then there is no second roll
		@rolls << 0 if pins == 10
	end

	def get_roll_points(roll_index)
		return 0 unless roll_nr.between?(1, MAX_ROLLS)

		@rolls[roll_index-1] || 0
	end

	def to_frames
		Frames.new(@rolls)
	end
end