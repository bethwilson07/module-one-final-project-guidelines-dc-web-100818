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

def get_top_level_user_input #only inputing numbers works.
  user_input = ""
  while user_input
    user_input = gets.downcase.strip
    case user_input
      when "1", "players"
        player_menu
      when "2", "teams"
        team_menu
      when "3", "leagues"
        league_options
      when "4", "help"
        help
      when "5", "exit"
        exit_soccer
      else
        puts "Please enter a valid option number."
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
  player_options
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
        player_stats_menu
      when "3"
        puts "Welcome back!"
        top_menu
      break
    else
      puts "Please enter a valid option number."
    end
  end
end


def search_player_by_country #have to enter in exact data
  user_input = ""
  puts "To search for players from a particular country, enter the country:"
  user_input = gets.capitalize.strip.to_s
  puts Player.all_players_from_nation(user_input)
end

def player_stats_menu
  puts "Player Stats
  1. Player's years with a team
  2. Shortest player in database
  3. Tallest player in database
  4. Player age by player"
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
  press 'q' to quit
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
  press 'q' to quit
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



def help #need to refactor to display menu options
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
  exit
end
