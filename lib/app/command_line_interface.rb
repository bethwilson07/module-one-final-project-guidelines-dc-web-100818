####################            BEGINNING USER SEARCH                ###################

require 'io/console'

def welcome
  puts "Hello! Welcome to SoccerInfo."
end

def main_menu
  puts "
  ----------------------------
  MAIN MENU

  1. Research Players
  2. Research Teams
  3. Research Leagues

  Press 'h' for help
  Press 'q' to quit
  -------------------------------
  "
  main_menu_input
end

def main_menu_input
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
      when "h", "help"
        help
      when "q", "exit", "quit"
        exit_soccer
      else
        puts "Please enter a valid menu option or press 'h' to view the menu again."
    end
  end
end

#############################  OPTION 1: PLAYER METHODS ###################################

def player_menu
  puts "
  -------------------------------
  PLAYER MENU

  1. Players By Country
  2. Player Lookup
  3. Tallest Player
  4. Shortest Player
  5. Previous Menu


  Press 'h' for help
  Press 'q' to quit
  --------------------------------
                              "
  player_menu_input
  #main_menu_input
end

def player_menu_input
  user_input = ""

  while user_input
    #puts "Please enter one of the above option numbers:"
    user_input = gets.downcase.strip

    case user_input
    when "1", "by country"
        puts players_by_country
      when "2", "lookup"
        #puts "-------------------------------"
        #player_stats_menu
        player_selection
      when "3", "tallest"
        puts Player.tallest_player
      when "4", "shortest"
        puts Player.shortest_player
      when "5", "previous", "previous menu"
        main_menu
        break
      #when "4",
      when "h", "help"
        player_menu
        break
      when "q", "quit"
        exit_soccer
    else
      puts "Please enter a valid menu option or press 'h' to view the menu again."
    end
  end
end

def player_selection
  found = []

  until found.size == 1
    puts "\nEnter a player name or press enter for a list of players: "

    player_search = gets.split(" ").map{|w| w.capitalize}.join(" ").strip

    found = Player.where("name LIKE ?",  "%#{player_search}%")

    if found.size > 1
      puts "\nSelect a player from the list: "

      found.each do |p|
        puts "#{p.name}"
      end

      puts "\n"

      player_search = gets.split(" ").map{|w| w.capitalize}.join(" ").strip

      exact_match = found.select { |p| p.name == player_search }

      if exact_match.size != 0
        found = exact_match
      else
        found = found.select { |p| p.name.include?(player_search) }
      end
    else
      puts "\nNo player found!"
    end
  end

  player_details_menu(found[0])
end

### Player option 1 ####
def players_by_country #have to enter in exact data
  #binding.pry

  puts "\nEnter a country or press enter for a list of players by country: "

  country = gets.split(" ").map{|w| w.capitalize}.join(" ").strip

  if country == ""
    countries = {}

    Player.all.each do |player|
      if countries[player.nationality].nil?
        countries[player.nationality] =[]
      end

      countries[player.nationality] << player.name
    end
    print_hash(countries)
  else
    country_selection(country)
  end
end

def print_hash(hash,spaces=4,level=0)
  hash.each do |key,val|
    format = "#{' '*spaces*level}#{key}:"
    if val.is_a? Array
      puts format
      puts "#{val.join("\n")}\n\n"
    else
      puts format + "#{val.join("\n")}\n\n"
    end
  end
  ""
end

def country_selection(country_search)
  found = []
  found_countries = []

  until found_countries.size == 1
    # puts "\nEnter a country or press enter for a list of players by country: "
    #
    # country_search = gets.split(" ").map{|w| w.capitalize}.join(" ").strip

    found = Player.where("nationality LIKE ?",  "%#{country_search}%")
    found_countries = found.collect { |p| p.nationality }.uniq
    #found.distinct!
    #binding.pry
    if found_countries.size > 1
      puts "\nSelect a country from the list: "

      found_countries.each do |c|
        puts "#{c}"
      end

      puts "\n"

      country_search = gets.split(" ").map{|w| w.capitalize}.join(" ").strip

      exact_match = found_countries.select { |c| c.downcase == country_search.downcase }

      #binding.pry
      if exact_match.size != 0
        found = found.select { |p| p.nationality == exact_match[0] }
        found_countries = exact_match
      else
        found = found.select { |p| p.nationality.downcase.include?(country_search.downcase) }
        found_countries = found.collect {|p| p.nationality }
      end
    else
      puts "\nNo country found!"
    end
  end

  #player_details_menu(found[0])
  #binding.pry
  #output =
  #found.each do |p|
  #end
  list_players_from_country(found, found_countries[0])
end

def list_players_from_country(players, country)
  output = "The following players are from #{country}:"

  players.each_with_index do |player, i|
    output += "\n#{i + 1}. #{player.name}"
  end

  output
end
### Player option 2 ###
def player_details_menu(player)
  puts "
  ---------------------------------------
  PLAYER DETAILS

  1. Current Team
  2. Age
  3. Position
  4. History
  5. Nationality
  6. Previous Menu
  7. Main Menu

  h - help
  q - exit program
  -----------------------------------------
  "

  player_details_menu_input(player)
end

def player_details_menu_input(player)
  user_input = ""

  while user_input
    user_input = gets.downcase.strip

    case user_input
      when "1", "team", "current team"
        puts current_team_info(player)
      when "2", "age"
        puts find_player_age(player)
      when "3", "position"
        puts find_player_position(player)
      when "4", "description"
        puts player.player_description
      when "5", "nationality"
        puts get_player_country(player)
      when "6", "previous", "previous menu"
        player_menu
        break
      when "7", "main", "main menu"
        main_menu
        break
      when "h"
        player_details_menu(player)
        break
      when "q"
        exit_soccer
      else
        puts "Please enter a valid menu option or press 'h' to view the menu again."
    end
  end
end

def get_player_country(player)
  "#{player.name} comes from #{player.nationality}."
end

## Player Stats option 1 (find player's team) ###

def current_team_info(player)
  "#{player.name} currently plays for #{player.team.name}. #{player.name} has been with #{player.team.name} for #{player.player_time_with_team}."
  # user_input = ""
  # puts "Enter the player:"
  # user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  # player = Player.find_by_name(user_input)
  # puts "#{player.name} plays for #{player.team.name}."
  # puts "
  # --------------------------------------------"
  # puts "Hit enter to return to previous menu"
  # gets.chomp
  # player_stats_menu
end

### Player Stats option 2 (find player's years with team) ####

# def player_years_with_team
#   user_input = ""
#   puts "Enter the player:"
#   user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
#   player = Player.find_by_name(user_input)
#   puts "#{player.name} has been with #{player.team.name} for #{player.player_time_with_team}."
#   puts "
#   --------------------------------------------"
#   puts "Hit enter to return to previous menu"
#   gets.chomp
#   player_stats_menu
# end

## Player stats option 3 (find player's age) ###

def find_player_age(player)
  "#{player.name} is #{player.age} years old."
  # user_input = ""
  # puts "Enter the player:"
  # user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  # player = Player.find_by_name(user_input)
  # puts "#{player.name} is #{player.age} years old."
  # puts "
  # --------------------------------------------"
  # puts "Hit enter to return to previous menu"
  # gets.chomp
  # player_stats_menu
end

## Player stats option 4 (find player's position) ###

def find_player_position(player)
  # user_input = ""
  # puts "Enter the player:"
  # user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  # player = Player.find_by_name(user_input)
  # puts "#{player.name} is a #{player.position} for #{player.team.name}."
  # puts "
  # --------------------------------------------"
  # puts "Hit enter to return to previous menu"
  # gets.chomp
  # player_stats_menu
  "#{player.name} plays #{player.position}."
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
  TEAM OPTIONS

  1. Oldest Team
  2. Youngest Team
  3. Select A Team
  4. Previous Menu

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
      when "2", "youngest"
        puts "\n#{Team.youngest}"
      when "3", "select a team"
        team_selection
        # puts "\nEnter a team name: "
        # team_search = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
        # #binding.pry
        # team = Team.where("name LIKE ?",  "%#{team_search}%").first ######### REFACTOR TO GIVE REFINED LIST FOR TEAM SELECTION ########
        # #binding.pry
        # team_details_menu(team)
      when "4", "p", "previous"
        main_menu
        break
      when "h", "help"
        team_menu
        break
      when "q", "exit", "quit"
        exit_soccer
      else
        puts "Please enter a valid menu option or press 'h' to view the menu again."
    end
  end
  # user_input = ""
  # puts "To get a particular team roster, enter the team:"
  # user_input = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  # team = Team.find_by_name(user_input)
  # puts team.get_team_roster
end

def team_selection
  found = []

  until found.size == 1
    puts "\nEnter a team name or press enter for a list of teams: "

    team_search = gets.split(" ").map{|w| w.capitalize}.join(" ").strip

    found = Team.where("name LIKE ?",  "%#{team_search}%")

    if found.size > 1
      puts "\nSelect a team from the list: "

      found.each do |t|
        puts "#{t.name}"
      end

      puts "\n"

      team_search = gets.split(" ").map{|w| w.capitalize}.join(" ").strip

      exact_match = found.select { |t| t.name == team_search }

      if exact_match.size != 0
        found = exact_match
      else
        found = found.select { |t| t.name.include?(team_search) }
      end
    else
      puts "\nNo team found!"
    end
  end

  team_details_menu(found[0])
end

################# TEAM DETAILS MENU #################

def team_details_menu(team)
  puts "
  ---------------------------
  TEAM DETAILS

  1. History
  2. Location
  3. Competition
  4. Roster
  5. Roster Size
  6. Team Manager
  7. Youngest Player
  8. Oldest Player
  9. Previous Menu
  10. Main Menu

  Press 'h' for help
  Press 'q' to quit
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
        #league_menu_input
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
      when "10", "main", "main_menu"
        main_menu
        break
      when "h", "help"
        team_details_menu(team)
        break
      when "q", "exit", "quit"
        exit_soccer
      else
        puts "Please enter a valid menu option or press 'h' to view the menu again."
    end
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
  puts "
  -----------------------------------------------------
  LEAGUE OPTIONS

  1. List Leagues
  2. League Search by Country
  3. League Lookup
  4. Largest League
  5. Smallest League
  6. Oldest League
  7. Youngest League
  8. Previous Menu

  Press 'h' for help
  Press 'q' to quit
  --------------------------------------------------
  "

  league_menu_input

  # get_user_input_from_league_menu
  # main_menu_input
end

def league_menu_input
  user_input = ""

  while user_input
    #puts "Please enter one of the above option numbers:"
    user_input = gets.downcase.strip
    case user_input
      when "1", "all leagues", "list leagues"
        puts list_of_all_leagues
      when "2", "country"
        leagues_in_country
      when "3", "lookup"
        league_selection()
      when "4", "largest"
        find_largest_league
      when "5", "smallest"
        find_smallest_league
      when "6", "oldest"
        find_oldest_league
      when "7", "youngest"
        find_youngest_league
      when "8", "previous", "previous menu"
        main_menu
        break
      when "h", "help"
        league_menu
        break
      when "q", "quit", "exit"
        exit_soccer
    else
      puts "Please enter a valid menu option or press 'h' to view the menu again."
    end
  end
end

def leagues_in_country
  found = []

  puts "\nEnter a country name: "
  league_search = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  found = League.where("nation LIKE ?", "%#{league_search}%")
  if found.size < 1
    puts "\nNo leagues were found in #{league_search}!"
  else
    puts "\nThere are #{found.size} leagues in #{found.sample.nation}. They are: "
    found.each do |l|
      puts "#{l.name}"
    end
  end

  league_menu
end

def league_selection(country_search=nil)
  found = []
  found_countries = []

  until found_countries.size == 1
    # puts "\nEnter a country or press enter for a list of players by country: "
    #
    # country_search = gets.split(" ").map{|w| w.capitalize}.join(" ").strip

    found = League.where("nation LIKE ?",  "%#{country_search}%")
    found_countries = found.collect { |l| l.nation }.uniq
    #found.distinct!
    #binding.pry
    if found_countries.size > 1
      puts "\nSelect a country from the list: "

      found_countries.each do |c|
        puts "#{c}"
      end

      puts "\n"

      country_search = gets.split(" ").map{|w| w.capitalize}.join(" ").strip

      exact_match = found_countries.select { |c| c.downcase == country_search.downcase }

      #binding.pry
      if exact_match.size != 0
        found = found.select { |l| l.nation == exact_match[0] }
        found_countries = exact_match
      else
        found = found.select { |l| l.nationa.downcase.include?(country_search.downcase) }
        found_countries = found.collect {|p| l.nation }
      end
    else
      puts "\nNo country found!"
    end
  end

  #player_details_menu(found[0])
  #binding.pry
  #output =
  #found.each do |p|
  #end
  #list_players_from_country(found, found_countries[0])
  # found = []
  #
  # until found.size == 1
  #   puts "\nEnter a league name or press enter for a list of leagues: "
  #
  #   league_search = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  #
  #   found = League.where("name LIKE ?",  "%#{league_search}%")
  #
  #   if found.size > 1
  #     puts "\nSelect a league from the list: "
  #
  #     found.each do |l|
  #       puts "#{l.name}"
  #     end
  #
  #     puts "\n"
  #
  #     league_search = gets.split(" ").map{|w| w.capitalize}.join(" ").strip
  #
  #     exact_match = found.select { |l| l.name == league_search }
  #
  #     if exact_match.size != 0
  #       found = exact_match
  #     else
  #       found = found.select { |l| l.name.include?(league_search) }
  #     end
  #   else
  #     puts "\nNo league found!"
  #   end
  # end
  #
  # team_details_menu(found[0])
end

########## League Menu Options ###############
def leagues_by_country #have to enter in exact data
  #binding.pry

  puts "\nEnter a country or press enter for a list of all leagues by country: "

  country = gets.split(" ").map{|w| w.capitalize}.join(" ").strip

  if country == ""
    countries = {}

    League.all.each do |l|
      if countries[l.nation].nil?
        countries[l.nation] = []
      end

      countries[l.nation] << l.name
    end
    print_hash(countries)
  else
  league_selection(country)
  end
end

def list_leagues_from_country(leagues, country)
  output = "The following leagues are played in #{country}:"

  players.each_with_index do |league, i|
    output += "\n#{i + 1}. #{league.name}"
  end

  output
end

####### Option 1 ###########
def list_of_all_leagues
  output = ""
  league_list = League.all.collect {|l| l.name}

  league_list.each do |l|
    output += "#{p}\n"
  end
  # puts "
  # --------------------------------------------"
  # puts "Hit enter to return to previous menu"
  # gets.chomp
  # league_menu
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

def league_details_menu(league)
  puts "
  ---------------------------
  LEAGUE DETAILS
  1. Teams
  2. League Size
  3. Players
  4. Managers
  5. History
  6. Oldest Team
  7. Youngest Team
  8. Previous Menu
  9. Main Menu

  Press 'h' for help
  Press 'q' to quit
  -----------------------------
  "

  #Please enter one of the above option numbers:

  # 10. Find the largest league in the database
  # 11. Find the smallest league in the database
  # 12. Find the oldest league in the database
  # 13. Find the youngest league in the database

  # get_user_input_from_league_stats
  # main_menu_input
  league_details_options(league)
end

def league_details_options(league)
  user_input = ""

  while user_input
    user_input = gets.downcase.strip

    case user_input
      when "1", "teams"
        puts teams_in_league
      when "2", "size"
        count_players_in_league
      when "3", "players"
        list_of_players_in_league
      when "4", "managers"
        list_of_managers_in_league
      when "5", "history"
        get_league_description
      when "6", "oldest"
        find_oldest_team_in_league
      when "7", "youngest"
        find_youngest_team_in_league
      when "8", "previous menu", "previous"
        league_menu
        break
      when "9", "main menu", "main"
        main_menu
        break
      when "h", "help"
        league_details_menu(league)
        break
      when "q", "quit", "exit"
        exit_soccer
      else
        puts "Please enter a valid menu option or press 'h' to view the menu again."
    end
  end
end

######### League Stats Options Methods ##############

def teams_in_league
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
  league_details_menu
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
  league_details_menu
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
  league_details_menu
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
  league_details_menu
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
  league_details_menu
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
  league_details_menu
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

end

def find_largest_league
  puts league = League.largest
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
end

def find_smallest_league
  puts league = League.smallest
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  #league_details_menu
end

def find_oldest_league
  puts league = League.oldest
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp

end

def find_youngest_league
  puts league = League.youngest
  puts "
  --------------------------------------------"
  puts "Hit enter to return to previous menu"
  gets.chomp
  league_details_menu
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
  main_menu_input
end

def exit_soccer
  puts "Goodbye"
  exit
end
