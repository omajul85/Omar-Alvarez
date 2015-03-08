# This class models the a player

class Player
	attr_accessor :name, :score
	
	def initialize(n)
		@name = n;
		@score = Scorer.new
	end
end