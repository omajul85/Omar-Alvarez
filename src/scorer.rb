# This class models the score of a player

class Scorer   
	attr_reader :totalScore, :rolls, :frameScores
	
	def initialize()
		@lastBallRolled = 0	
		@firstBallInFrame = 0
		@lastFrameNumber = 10
		@rollingFrame = 1
		@totalScore = 0
		@frameScores = [];
		@rolls = [];
		@state = "BALL_1"
	end
	
	# Each time a player rolls a ball, the method will return an array with the scores
	# that can be possibly calculated until that rollingFrame (frameScores)
	def roll(b)
		
		case (@state)
			when "BALL_1"
				if b < 10
					@firstBallInFrame = b
					@state = "BALL_2"
				else
					@rollingFrame += 1
					@state = "STRIKE_1"
				end
			when "BALL_2"							#Rolling a second ball
				@rollingFrame += 1
				if @firstBallInFrame + b == 10		#SPARE
					@state = "SPARE_1"
				else								#MISS
					# Compute the score for the current frame
					addScoreInFrame(@firstBallInFrame + b);
					@state = "BALL_1"
				end
			when "STRIKE_1"
				if b == 10							#TWO CONSECUTIVES STRIKES
					@rollingFrame += 1
					@state = "STRIKES_X2"
				else								#STRIKE TWO BALLS AGO
					@firstBallInFrame = b
					@state = "STRIKE_2"
				end
			when "STRIKES_X2"
				# Compute the bonus for the strike 2 balls ago
				addScoreInFrame(20 + b)
				if b == 10							#TWO CONSECUTIVES STRIKES (again)
					@rollingFrame += 1
				else								#STRIKE TWO BALLS AGO
					@firstBallInFrame = b
					@state = "STRIKE_2"
				end
			when "STRIKE_2"							#Rolling a second ball
				# Compute the bonus for the strike 2 balls ago
				addScoreInFrame(@firstBallInFrame + 10 + b)
				@rollingFrame += 1
				if @firstBallInFrame + b == 10		#SPARE
					@state = "SPARE_1"
				else								#MISS
					# Compute the bonus for the current frame
					addScoreInFrame(@firstBallInFrame + b)
					@state = "BALL_1"
				end
			when "SPARE_1"							
				# Compute the bonus for the spare 1 ball ago
				addScoreInFrame(10 + b)
				if b < 10
					@firstBallInFrame = b
					@state = "BALL_2"
				else
					@rollingFrame += 1
					@state = "STRIKE_1"
				end
			else
				puts "ERROR: Invalid state" + @state
		end
		return @frameScores
	end
	
	# Returns the current frame number
	def frameNumber
		if @frameScores.length == @lastFrameNumber			# frameNumber == 11 means the game is over
			return @lastFrameNumber + 1
		elsif @rollingFrame > @lastFrameNumber				# Handles the 10th frame in case of bonus
			return @lastFrameNumber
		else												# Frame on which the next ball will be rolled
			return @rollingFrame
		end
	end
	
	# Record the score in the array frameScores
	def addScoreInFrame(value)
		if @frameScores.length < @lastFrameNumber
			@totalScore += value
			@frameScores.push(@totalScore)
		end
	end
	
	# The game ends when the frameNumber == 11. Which means that the score of the 10th frame is recorded
	def gameIsOver
		return frameNumber() > @lastFrameNumber
	end
	
	# This method simulates the rolling process by generating a random number of pins within
	# the rules of the game, i.e, if a player rolls 4 pins in the 1st ball of a frame, in the
	# 2nd ball just a maximum of 6 pins can be knocked
	def pins
		if @state == "BALL_2" || @state == "STRIKE_2"
			@lastBallRolled = rand(0..10 - @lastBallRolled)
		else
			@lastBallRolled = rand(0..10)
		end
		@rolls.push(@lastBallRolled)
		return @lastBallRolled
	end
	
	# Print the score of a player recorded until the current frame
	def printScore
		
		# Row with the frame number
		(1..@lastFrameNumber).each do |f|
			print "F" + f.to_s, "\t"
		end
		puts ""
		
		# Row with the balls rolled
		index = 0
		while index < @rolls.length
			if @rolls[index] < 10
				# In case of spare in the last frame
				if index == @rolls.length - 1
					if @rolls[index] != 10
						print @rolls[index].to_s, "\t"
					else
						#In case of strike in the last roll
						print "X\t"
					end
				else
					if @rolls[index] + @rolls[index + 1] == 10
						print @rolls[index].to_s, "|/\t"
					else
						print @rolls[index].to_s, "|", @rolls[index + 1].to_s, "\t"
					end
				end
				if index < @rolls.length
					index += 2
				end
			else
				print "X\t"
				index += 1
			end
		end
		puts ""
		
		#Row with the scores per frame
		(0...@frameScores.length).each do |f|
			print @frameScores[f].to_s, "\t"
		end
		puts ""
	end
end