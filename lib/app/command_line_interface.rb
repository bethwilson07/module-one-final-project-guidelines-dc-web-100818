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
end

def get_top_level_user_input #only inputing numbers works.
  user_input = ""
  tells_user_what_to_do
  while user_input
    user_input = gets.downcase.strip
    case user_input
      when "1" || "research players"
        player_menu
      when "2" || "research teams"
        team_menu
      when "3" || "research leagues"
        league_options
      when "4" || "help"
        help
      when "5" || "exit"
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
        puts "Welcome back!"
        tells_user_what_to_do
      break
    else
      "Please enter a valid option number."
    end
  end
end


def search_player_by_country #have to enter in exact data
  user_input = ""
  puts "To search for players from a particular country, enter the country:"
  user_input = gets.capitalize.strip.to_s
  puts Player.all_players_from_nation(user_input)
  puts "
  --------------------------------------------"
  player_menu
  get_user_input_from_player_menu
end

def player_stats_menu
  puts "Player Stats
  1. Player's years with a team
  2. Shortest player in database
  3. Tallest player in database
  4. Player age by player
  5. Return to Player Options Menu "
end

def get_user_input_from_player_stats
  user_input = ""
  while user_input
    puts "Please enter one of the above option numbers:"
    user_input = gets.downcase.strip
    case user_input
      when "1"
        "method for player's years with a team"
      when "2"
        puts "-------------------------------"
        "method for shortest player in database"
      when "3"
        "method tallest player "
      when "4"
        "player age by player"
      when "5"
        puts "Welcome back!"
        player_menu
      break
    else
      "Please enter a valid option number."
    end
  end
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
end

def player
  puts "To search within players..."
end

def exit_soccer
  puts "Goodbye"
end
