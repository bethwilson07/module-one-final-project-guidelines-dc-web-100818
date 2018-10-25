####################            BEGINNING USER SEARCH                ###################
def welcome
  puts "Hello! Welcome to SoccerInfo."
end

def tells_user_what_to_do
  puts "----------------------------
  Menu Options:
  1. Research players
  2. Research teams
  3. Research leagues
  4. Help
  5. Exit program
  --------------------------------------

  What would you like to search for today?

  Please enter one of the above option numbers:
  "
  get_top_level_user_input
end

def get_top_level_user_input #only inputing numbers works.
  user_input = ""
  while user_input
    user_input = gets.downcase.strip
    case user_input
      when "1"
        player_menu
      when "2"
        team_menu
      when "3"
        league_options
      when "4"
        help
      when "5"  #exits program only at top level -- not when called after looping through other methods
        exit_soccer
      break
      else
        "Please enter a valid option number."
      end
    end
end

#############################  OPTION 1: PLAYER METHODS ###################################

def player_menu
  puts "Player Menu Options:
  1. Search players by country
  2. Find player stats
  3. Return to previous menu
  "
  get_user_input_from_player_menu
end

def get_user_input_from_player_menu
  user_input = ""
  while user_input
    puts "Please enter one of the above option numbers:"
    user_input = gets.downcase.strip
    case user_input
      when "1"
        search_player_by_country
      when "2"
        puts "-------------------------------"
        player_stats_menu
      when "3"
        puts "Welcome back!" ###doesn't exit program when we return to top level
        tells_user_what_to_do
      break
    else
      "Please enter a valid option number."
    end
  end
end

### Player option 1 ####
def search_player_by_country #have to enter in exact data
  user_input = ""
  puts "To search for players from a particular country, enter the country:"
  user_input = gets.capitalize.strip.to_s
  puts Player.all_players_from_nation(user_input)
  puts "
  --------------------------------------------"
  player_menu
end

### Player option 2 ###
def player_stats_menu
  puts "Player Stats
  1. Player's years with a team
  2. Shortest player in database
  3. Tallest player in database
  4. Player age by player
  5. Return to Player Options Menu


  Please enter one of the above option numbers:"

  get_user_input_from_player_stats
end

def get_user_input_from_player_stats
  user_input = ""
  while user_input
    user_input = gets.downcase.strip
    case user_input
      when "1"
        player_years
      when "2"
        find_shortest_player
      when "3"
        find_tallest_player
      when "4"
        find_player_age
      when "5"
        puts "Welcome back!"
        player_menu
      break
    else
      puts "Please enter a valid option number."
    end
  end
end

### Player Stats option 1 (find player's years with team) ####
def player_years
  user_input = ""
  puts "Enter the player:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  player = Player.find_by_name(user_input)
  puts "#{player.name} has been with #{player.team.name} for #{player.player_time_with_team}."
  puts "
  --------------------------------------------"
  player_stats_menu
end

## Player stats option 2 (find shortest player in database) ###

def find_shortest_player
  puts Player.shortest_player
  puts "
  --------------------------------------------"
  player_stats_menu
end

### Player stats option 3 (find tallest player in database) ###
def find_tallest_player
  puts Player.tallest_player
  puts "
  --------------------------------------------"
  player_stats_menu
end

## Player stats option 4 (find player age by player) ###

def find_player_age
  user_input = ""
  puts "Enter the player:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  player = Player.find_by_name(user_input)
  puts "#{player.name} is #{player.age} years old."
  puts "
  --------------------------------------------"
  player_stats_menu
end


######################### OPTION 2 TEAM METHODS ###########################

def team_menu
  puts "Team Menu Options
  1. Oldest Team in database
  2. Youngest Team in database
  3. Team roster
  4. Team player count
  5. Youngest player by team
  6. Oldest player by team
  "
end

def team_options
  user_input = ""
  puts "To get a particular team roster, enter the team:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  team = Team.find_by_name(user_input)
  puts team.get_team_roster


end

############################## OPTION 3 LEAGUE METHODS ###########################

def league_options
  user_input = ""
  puts "To get a list of all soccer leagues, enter 'yes'"
  user_input = gets.chomp
  if user_input == "yes"
  puts League.all.collect{|league| league.name}
  else
  puts "You're no fun."
  end
end

############################ OTHER METHODS ################################



def help
  puts"-------------------------
  Here are your menu options:
  1. Research players
  2. Research teams
  3. Research leagues
  4. Help
  5. Exit program
  ------------------------------"
  get_top_level_user_input
end

def player
  puts "To search within players..."
end

def exit_soccer
  puts "Goodbye"
end
