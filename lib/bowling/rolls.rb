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