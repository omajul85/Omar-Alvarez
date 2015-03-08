# This class models a bowling game

class Game
	attr_accessor :vPlayers
	
	def initialize()
		@vPlayers = [];
	end
	
	# This method (used for testing purposes) simulates a round of the game.
	# Each player will roll balls until the game is over.
	def simulation
		@vPlayers.each {|player|
			loop{
				player.score.roll(player.score.pins)
				if player.score.gameIsOver == true
					break
				end
			}
		}
	end
	
	# This methods simulates a round of the game. It prints the name and scores of all the players 
	# updating the information for every frame
	def simulation2
		(1..10).each do |f|
			@vPlayers.each {|player|
				loop{
					system('cls')
					puts "BOWLING BBC", ""
					player.score.roll(player.score.pins)
					
					# The turn of the player ends when the score of the current frame is calculated
					if player.score.frameNumber > f
						@vPlayers.each {|player|
							print player.name + "(" + player.score.totalScore.to_s + ")\n" 
							player.score.printScore
							puts ""
						}
						#sleep(0.1)
						break
					end
				}
			}			
		end	
	end
	
	# Returns the winner of the game
	def winner
		s = {}
		@vPlayers.each {|player|
			s[player.name.to_s] = player.score.totalScore
		}
		max = s.values.max
		name = s.select{|k, v| v == max}.keys
		score = s.select{|k, v| v == max}.values
		
		print "The winner is " + name[0].to_s + " with a total score of " + score[0].to_s
		puts "",""
		
	end
	
	# This method contains the group of actions(methods) to start a game
	# 1. Creation of the players (using a list of names)
	# 2. Simulates the round
	# 3. Print the winner
	def start(list)
		@vPlayers = [];
		
		# Adding players to the game
		list.each {|name|
			player = Player.new(name)
			@vPlayers.push(player)
		}
		
		# Launch the simulation of the game
		simulation2()

		# Print the winner
		winner()
	end
end