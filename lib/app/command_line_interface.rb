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

def get_top_level_user_input
  user_input = ""
  while user_input
    user_input = gets.downcase.strip
    case user_input
      when "1"
        player_menu
      when "2"
        team_menu
      when "3"
        league_menu
      when "4"
        help
      when "h"
        help
      when "5"
        exit_soccer
      when "q"
        exit_soccer
      else
        "Please enter a valid option number."
      end
    end
end

#############################  OPTION 1: PLAYER METHODS ###################################

def player_menu
  puts "Player Options Menu:
  1. Search players by country
  2. Find player stats
  3. Return to previous menu


    h - help
    q - exit program
                              "
  get_user_input_from_player_menu
  get_top_level_user_input
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
      when "h"
        help
      break
      when "q"
        exit_soccer
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
  puts "Hit enter to return to previous menu"
  gets.chomp
  player_menu
end

### Player option 2 ###
def player_stats_menu
  puts "Player Stats Options Menu:

  1. Find a player's team
  2. Find a player's amount of time with his team
  3. Find a player's age
  4. Get a player's position
  5. Get a player's history/description
  6. Find a player's nationality
  7. Find the tallest player in the database
  8. Find the shortest player in the database

  9. Return to Player Options Menu

  h - help
  q - exit program

  Please enter one of the above option numbers:"

  get_user_input_from_player_stats
  get_top_level_user_input
end

def get_user_input_from_player_stats
  user_input = ""
  while user_input
    user_input = gets.downcase.strip
    case user_input
      when "1"
        find_player_team
      when "2"
        player_years_with_team
      when "3"
        find_player_age
      when "4"
        find_player_posiiton
      when "5"
        find_player_description
      when "6"
        find_player_nationality
      when "7"
        find_tallest_player
      when "8"
        find_shortest_player
      when "9"
        puts "Welcome back!"
        player_menu
        break
      when "h"
        help
        break
      when "q"
        exit_soccer
      else
        puts "Please enter a valid option number."
    end
  end
end

## Player Stats option 1 (find player's team) ###

def find_player_team
  user_input = ""
  puts "Enter the player:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  player = Player.find_by_name(user_input)
  puts "#{player.name} plays for #{player.team.name}."
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  player_stats_menu
end

### Player Stats option 2 (find player's years with team) ####

def player_years_with_team
  user_input = ""
  puts "Enter the player:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  player = Player.find_by_name(user_input)
  puts "#{player.name} has been with #{player.team.name} for #{player.player_time_with_team}."
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  player_stats_menu
end

## Player stats option 3 (find player's age) ###

def find_player_age
  user_input = ""
  puts "Enter the player:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  player = Player.find_by_name(user_input)
  puts "#{player.name} is #{player.age} years old."
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  player_stats_menu
end

## Player stats option 4 (find player's position) ###

def find_player_posiiton
  user_input = ""
  puts "Enter the player:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  player = Player.find_by_name(user_input)
  puts "#{player.name} is a #{player.position} for #{player.team.name}."
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  player_stats_menu
end

## Player stats option 5 (get player's history/description) ###

def find_player_description
  user_input = ""
  puts "Enter the player:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  player = Player.find_by_name(user_input)
  puts player.player_description
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  player_stats_menu
end

## player stats option 6 (find a player's nationality) ####

def find_player_nationality
  user_input = ""
  puts "Enter the player:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  player = Player.find_by_name(user_input)
  puts "#{player.name} is from #{player.nationality}."
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  player_stats_menu
end

## Player stats option 7 (find tallest player in database) ###

def find_tallest_player
  puts Player.tallest_player
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  player_stats_menu
end

## Player stats option 8 (find shortest player in database) ###

def find_shortest_player
  puts Player.shortest_player
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
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

def league_menu
  puts "League Options Menu:
  1. Get list of all soccer leagues
  2. Search leagues by country
  3. Find league stats
  4. Return to previous menu


    h - help
    q - exit program
                              "
  get_user_input_from_league_menu
  get_top_level_user_input
end

def get_user_input_from_league_menu
  user_input = ""
  while user_input
    puts "Please enter one of the above option numbers:"
    user_input = gets.downcase.strip
    case user_input
      when "1"
        list_of_all_leagues
      when "2"
        find_league_by_country
      when "3"
        puts "-------------------------------"
        league_stats_menu
      when "4"
        puts "Welcome back!"
        tells_user_what_to_do
      break
      when "h"
        help
      break
      when "q"
        exit_soccer
        exit
    else
      "Please enter a valid option number."
    end
  end
end

########## League Menu Options ###############

####### Option 1 ###########
def list_of_all_leagues
  puts League.all.collect {|league| league.name}
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  league_menu
end
########## Option 2 #############
def find_league_by_country
  user_input = ""
  puts "To search for leagues from a particular country, enter the country:"
  user_input = gets.capitalize.strip.to_s
  puts League.by_nation(user_input)
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  league_menu
end

########## Option 3 ###########

def league_stats_menu
  puts "League Stats Options Menu:

  1. Get list of all teams in a league
  2. Find number of players in a league
  3. Find all players from a league
  4. Get a list of managers in a league
  5. Get a league's history/description
  6. Get the year a league was founded and its age
  7. Find league's country
  8. Find the oldest team in a league
  9. Find the youngest team in a league
  10. Find the largest league in the database
  11.Find the smallest league in the database
  12.Find the oldest league in the database
  13.Find the youngest league in the database

  14. Return to League Options Menu

  h - help
  q - exit program

  Please enter one of the above option numbers:"

  get_user_input_from_league_stats
  get_top_level_user_input
end

def get_user_input_from_league_stats
  user_input = ""
  while user_input
    user_input = gets.downcase.strip
    case user_input
      when "1"
        list_of_teams_in_league
      when "2"
        count_players_in_league
      when "3"
        list_of_players_in_league
      when "4"
        list_of_managers_in_league
      when "5"
        get_league_description
      when "6"
        get_year_founded_and_age
      when "7"
        get_league_country
      when "8"
        find_oldest_team_in_league
      when "9"
        find_youngest_team_in_league
      when "10"
        find_largest_league
      when "11"
        find_smallest_league
      when "12"
        find_oldest_league
      when "13"
        find_youngest_league
      when "14"
        puts "Welcome back!"
        league_menu
        break
      when "h"
        help
        break
      when "q"
        exit_soccer
        exit
      else
        puts "Please enter a valid option number."
    end
  end
end

######### League Stats Options Methods ##############

def list_of_teams_in_league
end

def count_players_in_league
end

def list_of_players_in_league
end

def list_of_managers_in_league
end

def get_league_description
end

def get_year_founded_and_age
end

def get_league_country
end

def find_oldest_team_in_league
end

def find_youngest_team_in_league
end

def find_largest_league
end

def find_smallest_league
end

def find_oldest_league
end

def find_youngest_league
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

def exit_soccer
  puts "Goodbye"
  exit
end
