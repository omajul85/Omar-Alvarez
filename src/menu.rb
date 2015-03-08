# This class models a classic console menu for a bowling game

class Menu
	
	def initialize()
		@namesOfPlayers = [];
		#Options menu
		option = ""
		while option != "5" do
			option = optionsMenu
			case(option)
				
				# Add a player
				when "1"
					if @namesOfPlayers.length > 5
						system('cls')
						puts "","Sorry, the max number of players is 6"
						system('pause')
					else
						loop{
							system('cls')
							print "Enter the name of the player: "
							name = gets().chomp
							name.upcase!
							if @namesOfPlayers.include?(name)
								puts "","Sorry, that name is already taken",""
								system('pause')
							elsif !name.nil?
								@namesOfPlayers.push(name)
								puts "", name + " added correctly",""
								system('pause')
								break
							end
						}
					end
				
				# Remove a player
				when "2"
					if @namesOfPlayers.empty?
						puts "","The list of players is empty",""
						system('pause')
					else
						puts "Enter the number of the player that you want to remove"
						printListOfPlayers()
						print "=> "
						remove = gets().chomp.to_i
						@namesOfPlayers.delete_at(remove-1)
					end
				
				# See list of players
				when "3"
					if @namesOfPlayers.empty?
						puts "","The list of players is empty",""
						system('pause')
					else
						system('cls')
						puts "List of players",""
						printListOfPlayers()
						puts ""
						system('pause')
					end
				
				
				# Play
				when "4"
					if @namesOfPlayers.empty?
						puts "","The list of players is empty",""
						system('pause')
					else
						loop{ 
							bbc_bowling = Game.new
							bbc_bowling.start(@namesOfPlayers)
							if !playAgain()
								break
							end
						}
						option = "5"
					end
				
				# Quit
				when "5"
						break
				
				else
					puts "ERROR: Invalid option. Try again!",""
					system('pause')
			end
			
		end
		#Exit the game
		puts "","Thanks for playing. See you soon!"
	end
						
	# Print the list of players (each player has a number)
	def printListOfPlayers
		i = 0
		@namesOfPlayers.each {|name|
			print (i += 1 ).to_s + ": " + name + "\t\t"
		}
		puts ""
	end

	# Print the menu of the game and returns the option selected
	def optionsMenu
		system('cls')
		puts "Welcome to Bowling BBC",""
		puts "\t1 - Add a player"
		puts "\t2 - Remove a player"
		puts "\t3 - See list of players"
		puts "\t4 - Play"
		puts "\t5 - Quit"
		print "\nPlease choose an option: "
		input = gets().chomp
		return input
	end
	
	# Propose a new game and returns a boolean with the answer
	def playAgain
		selection = ""
		print "","Do you want to play again [Y/N]? "
		while selection != "N" do
			selection = gets().chomp.upcase
			if selection == "Y"
				return true
			elsif selection == "N"
				return false
			else
				puts "","ERROR: Invalid option. Try again!"
				print "","Do you want to play again [Y/N]? "
			end
		end		
	end
end
