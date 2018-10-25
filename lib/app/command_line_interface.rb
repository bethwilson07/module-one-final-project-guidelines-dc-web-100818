####################            BEGINNING USER SEARCH                ###################

require 'io/console'

def welcome
  puts "Hello! Welcome to SoccerInfo."
end

def top_menu
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
      when "1", "players"
        player_menu
      when "2", "teams"
        team_menu
      when "3", "leagues"
        league_menu
      when "4", "h", "help"
        help
      when "5", "q", "exit"
        exit_soccer
      else
        puts "Please enter a valid option number."
    end
  end
end

#############################  OPTION 1: PLAYER METHODS ###################################

def player_menu
  puts "---------------------------------------
  Player Options Menu:

  1. Search players by country
  2. Find the tallest player in the database
  3. Find the shortest player in the database
  4. Find player stats
  5. Return to previous menu


  press 'h' for help
  press 'q' to exit the program
  ---------------------------------------
                              "
  player_options
  get_top_level_user_input
end

def player_options
  user_input = ""

  while user_input
    puts "Please enter one of the above option numbers:"
    user_input = gets.downcase.strip
    case user_input
      when "1"
        search_player_by_country
      when "2"
        find_tallest_player
      when "3"
        find_shortest_player
      when "4"
        player_stats_menu
      when "3"
        puts "Welcome back!"
        top_menu
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
  puts " -------------------------------
  Player Stats Options Menu:

  1. Find a player's team
  2. Find a player's amount of time with his team
  3. Find a player's age
  4. Get a player's position
  5. Get a player's history/description
  6. Find a player's nationality

  9. Return to Player Options Menu

  press 'h' for help
  press 'q' to exit the program
  -------------------------------------------

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
  puts "
  -------------------------------------
  Team Menu Options

  1. Find the oldest team
  2. Find the youngest Team
  3. Select a team to learn more
  4. Return to previous menu

  press 'h' for help
  press 'q' to exit the program
  -------------------------------------
  "
  # 3. Get a team roster
  # 4. Team player count
  # 5. Youngest player by team
  # 6. Oldest player by team
  # "

  team_options
end

def team_options
  user_input = ""

  while user_input
    user_input = gets.downcase.strip
    case user_input
      when "1", "oldest"
        puts "\n#{Team.oldest}"
        team_menu
      when "2", "youngest"
        puts "\n#{Team.youngest}"
        team_menu
      when "3", "select a team"
        team_selection
        # puts "\nEnter a team name: "
        # team_search = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
        # #binding.pry
        # team = Team.where("name LIKE ?",  "%#{team_search}%").first ######### REFACTOR TO GIVE REFINED LIST FOR TEAM SELECTION ########
        # #binding.pry
        # team_details_menu(team)
      when "4", "p", "previous"
        top_menu
        break
      when "h", "help"
        team_menu
      when "q", "exit", "quit"
        exit_soccer
      else
        puts "Please enter a valid option number."
    end
  end
  # user_input = ""
  # puts "To get a particular team roster, enter the team:"
  # user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  # team = Team.find_by_name(user_input)
  # puts team.get_team_roster
end

def team_selection
  # puts "\nEnter a team name: "
  # team_search = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  # #binding.pry
  # found = Team.where("name LIKE ?",  "%#{team_search}%")

  found = []

  until found.size == 1
    puts "\nEnter a team name: "
    team_search = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
    found = Team.where("name LIKE ?",  "%#{team_search}%")

    if found.size < 1
      puts "\nNo team found!"
    else
      puts "\nSelect a team from the list: "
      found.each do |t|
        puts "#{t.name}"
      end

      team_search = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
      found = found.select { |t| t.name === team_search }
      if found.nil?
        found.select { |t| t.name.include?(team_search) }
      end
    end
  end

  team_details_menu(found.first)
end

################# TEAM DETAILS MENU #################

def team_details_menu(team)
  puts "----------------------
  Team Details
  1. History
  2. Location
  3. Competition
  4. Roster
  5. Roster size
  6. Team manager
  7. Youngest player
  8. Oldest player


  press 'h' for help
  press 'q' to exit the program
  -----------------------------
  "

  team_details_options(team)
end

def team_details_options(team)
  user_input = ""
  #binding.pry
  while user_input
    user_input = STDIN.noecho(&:gets).chomp #gets.downcase.strip

    case user_input
      when "1", "history"
        puts team.description
      when "2", "location"
        puts get_location_info(team)
      when "3", "competition"
        puts get_competition(team)
        #league_options
      when "4", "roster"
        puts get_roster(team)
      when "5", "roster size"
        puts get_roster_size(team)
      when "6", "manager"
        puts get_manager(team)
      when "7", "youngest"
        puts team.youngest_player
      when "8", "oldest"
        puts team.oldest_player
      when "9", "p", "previous"
        team_menu
        break
      when "h", "help"
        team_details_menu
      when "q", "exit", "quit"
        exit_soccer
      else
        puts "Please enter a valid option number."
    end

    team_details_menu(team)
  end
end

def get_location_info(team)
  "#{team.name} is located in #{team.city}. #{team.name} plays at #{team.stadium_name} located in #{team.stadium_location}"
end

def get_competition(team)
  league = team.league
  league_teams = league.teams.collect { |t| t.name }

  output = "#{team.name} competes in the #{league.name}. #{team.name} plays against:\n\n"

  league_teams.each do |t|
    #binding.pry
    if(team.name != t)
      output += "#{t}\n"
    end
  end

  output
end

def get_roster(team)
  roster = team.players.collect { |p| "#{p.name} - #{p.position} - #{p.height} - #{p.weight}"}

  output = "NAME - POSITION - HEIGHT - WEIGHT\n\n"

  roster.each do |p|
    #binding.pry
    output += "#{p}\n"
  end

  output
end

def get_roster_size(team)
  "There are #{team.players.size} players on #{team.name}."
end

def get_manager(team)
  "#{team.name}'s manager is #{team.manager}."
end
############################## OPTION 3 LEAGUE METHODS ###########################

def league_menu
  puts "------------------------------
  League Options Menu:

  1. Get list of all soccer leagues
  2. Search leagues by country
  3. Find the largest league in the database
  4. Find the smallest league in the database
  5. Find the oldest league in the database
  6. Find the youngest league in the database
  7. Select a league to learn more
  8. Return to previous menu


  press 'h' for help
  press 'q' to exit the program
  ------------------------------------
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
        find_largest_league
      when "4"
        find_smallest_league
      when "5"
        find_oldest_league
      when "6"
        find_youngest_league
      when "7"
        league_stats_menu
      when "8"
        puts "Welcome back!"
        top_menu
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
  puts "-------------------------------------------------
  League Stats Options Menu:

  1. Get list of all teams in a league
  2. Find number of players in a league
  3. Find all players from a league
  4. Get a list of managers in a league
  5. Get a league's history/description
  6. Get the year a league was founded, its age, & number of teams.
  7. Find league's country
  8. Find the oldest team in a league
  9. Find the youngest team in a league

  10. Return to League Options Menu

  h - help
  q - exit program

  -------------------------------------------------------

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
        get_year_founded_and_age_and_count
      when "7"
        get_league_country
      when "8"
        find_oldest_team_in_league
      when "9"
        find_youngest_team_in_league
      when "10"
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
  user_input = ""
  puts "Enter the league:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  league = League.find_by_name(user_input)
  puts "----------------------------
  #{league.name}'s teams are: "
  puts "#{league.list_teams}"
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  league_stats_menu
end

def count_players_in_league
  user_input = ""
  puts "Enter the league:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  league = League.find_by_name(user_input)
  puts "----------------------------
  #{league.name} has #{league.player_count} players."
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  league_stats_menu
end

def list_of_players_in_league
  user_input = ""
  puts "Enter the league:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  league = League.find_by_name(user_input)
  puts "----------------------------
  #{league.name}'s players are: "
  puts "#{league.list_players}"
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  league_stats_menu
end

def list_of_managers_in_league
  user_input = ""
  puts "Enter the league:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  league = League.find_by_name(user_input)
  puts "----------------------------
  #{league.name}'s managers are: "
  puts "#{league.managers}"
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  league_stats_menu
end

def get_league_description
  user_input = ""
  puts "Enter the league:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  league = League.find_by_name(user_input)
  puts "#{league.description}"
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  league_stats_menu
end

def get_year_founded_and_age_and_count
  user_input = ""
  puts "Enter the league:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  league = League.find_by_name(user_input)
  puts "----------------------------
  #{league.name} was founded in #{league.year_founded}.
  It is #{league.league_age} years old and has #{league.league_size} teams."
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  league_stats_menu
end

def get_league_country
  user_input = ""
  puts "Enter the league:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  league = League.find_by_name(user_input)
  puts "----------------------------
  #{league.name} is based out of #{league.nation}."
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  league_stats_menu
end

def find_oldest_team_in_league
  user_input = ""
  puts "Enter the league:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  league = League.find_by_name(user_input)
  puts league.oldest_team
  puts"
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  league_stats_menu
end

def find_youngest_team_in_league
  user_input = ""
  puts "Enter the league:"
  user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  league = League.find_by_name(user_input)
  puts league.youngest_team
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  league_stats_menu
end

def find_largest_league
  puts league = League.largest
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  league_stats_menu
end

def find_smallest_league
  puts league = League.smallest
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  league_stats_menu
end

def find_oldest_league
  puts league = League.oldest
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  league_stats_menu
end

def find_youngest_league
  puts league = League.youngest
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  league_stats_menu
end


############################ OTHER METHODS ################################


def help #need to refactor to display menu options
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
