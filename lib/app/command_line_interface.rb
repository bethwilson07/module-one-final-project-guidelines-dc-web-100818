
def welcome
  puts "Hello! Welcome to SoccerInfo."
end

def tells_user_what_to_do
  puts "Options:
  1. Research players
  2. Research teams
  3. Research leagues
  4. Help
  5. Exit program

  What would you like to search for today?"
end

def get_user_input
  user_input = ""
  while user_input
    puts "Please enter one of the above options:"
    user_input = gets.downcase.strip
    case user_input
      when "1" || "research players"
        player_options
      when "2" || "research teams"
        puts "See team options"
      when "3" || "research leagues"
        puts "See league options"
      when "4" || "help"
        help
      when "5" || "exit"
        exit_soccer
        break
      else
        help
      end
    end
end

def player_options
  user_input = ""
  puts "To search for players from a particular country, enter the country:"
  user_input = gets.capitalize.strip.to_s
  puts Player.all_players_from_nation(user_input)
end

def team_options
  user_input = ""
  puts "To get a particular team roster, enter the team:"
  user_input = gets.captialize.strip.to_s
  puts user_input.get_team_roster
end

def league_options
end




def help
  puts "I accept the following commands:
  - help : displays this help message
  - player : shows you all player search options
  - team : shows you all team search options
  - league : shows you all league search options
  - exit : exits this program"
end

def player
  puts "To search within players..."
end

def exit_soccer
  puts "Goodbye"
end
