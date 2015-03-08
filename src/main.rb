path = Dir.pwd.to_s
path += "/*.rb"
Dir[path].each{|file| 
	if File.basename(file).to_s != "main.rb"
		require file
	end
}

# This is the main function. To start a game, you just need to create an object of type Menu
MyMenu = Menu.new
