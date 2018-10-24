require 'rest-client'
require 'json'
require  'pry'


############# HELPER METHODS #################

def get_league_ids(leagues)
  ### gets ids for each soccer league
  leagues.collect { |league| league['idLeague'] }
end




########### GETS LEAGUES FROM APIS #############

def get_soccer_leagues_from_api
  sports_leagues = JSON.parse(RestClient.get('https://www.thesportsdb.com/api/v1/json/1/all_leagues.php'))

  soccer_leagues = sports_leagues['leagues'].select{ |league| league['strSport'] == 'Soccer' && league["strLeague"] != "_No League"}

  soccer_leagues.each do |league|
      league_details = JSON.parse(RestClient.get('https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id=' + league["idLeague"]))['leagues'][0]

      new_league = League.create(
        name: league_details['strLeague'],
        year_founded: league_details['intFormedYear'],
        nation: league_details["strCountry"],
        description: league_details['strDescriptionEN']
      )

      league_teams = JSON.parse(RestClient.get('https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=' + league["idLeague"]))['teams']

      if(league_teams != nil)
        league_teams.each do |team|
          new_team = Team.create(
            league: new_league,
            name: team["strTeam"],
            manager: team["strManager"],
            year_founded: team["intFormedYear"],
            stadium_name: team["strStadium"],
            stadium_location: team["strStadiumLocation"],
            description: team["strDescriptionEN"]
          )

        team_players = JSON.parse(RestClient.get('https://www.thesportsdb.com/api/v1/json/1/lookup_all_players.php?id=' + team["idTeam"]))["player"]

        if team_players != nil
          team_players.each do |player|
            Player.create(
              team: new_team,
              name: player["strPlayer"],
              birthdate: player["dateBorn"],
              date_signed: player["dateSigned"],
              signing_status: player["strSigning"],
              birth_location: player["strBirthLocation"],
              player_description: player["strDescriptionEN"],
              position: player["strPosition"],
              height: player["strHeight"],
              weight: player["strWeight"],
              nationality: player["strNationality"]
            )
          end
        end
      end
    end
  end
end
#
#
# ########### GETS LEAGUE DETAILS #####################
#
# def get_league_details(leagues)
#   get_league_ids(leagues).each do |id|
#     league_details = JSON.parse(RestClient.get('https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id=' + id))['leagues'][0]
#     #binding.pry
#
#     league = League.create(
#       name: league_details['strLeague'],
#       year_founded: league_details['intFormedYear'],
#       nation: league_details["strCountry"],
#       description: league_details['strDescriptionEN']
#     )
#
#     league_teams = JSON.parse(RestClient.get('https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=' + id))['teams']
#
#     if(league_teams != nil)
#       league_teams.each do |team|
#         new_team = Team.create(
#           league: league,
#           name: team["strTeam"],
#           manager: team["strManager"],
#           year_founded: team["intFormedYear"],
#           stadium_name: team["strStadium"],
#           stadium_location: team["strStadiumLocation"],
#           description: team["strDescriptionEN"]
#         )
#
#         team_players = JSON.parse(RestClient.get('https://www.thesportsdb.com/api/v1/json/1/lookup_all_players.php?id=' + team["idTeam"]))["player"]
#
#         if team_players != nil
#           team_players.each do |player|
#             Player.create(
#               team: new_team,
#               name: player["strPlayer"],
#               birthdate: player["dateBorn"],
#               date_signed: player["dateSigned"],
#               signing_status: player["strSigning"],
#               birth_location: player["strBirthLocation"],
#               player_description: player["strDescriptionEN"],
#               position: player["strPosition"],
#               height: player["strHeight"],
#               weight: player["strWeight"],
#               nationality: player["strNationality"]
#             )
#           end
#         end
#       end
#     end
#   end
# end

############ GETS TEAMS FOR LEAGUES #############

# def get_league_teams(leagues)
#   get_league_ids(leagues).each do |id|
#     league_teams = JSON.parse(RestClient.get('https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=' + id))['teams']
#
#     if(league_teams != nil)
#       league_teams.each do |team|
#         Team.create(
#           league: League.find_by(name: team["strLeague"]),
#           name: team["strTeam"],
#           manager: team["strManager"],
#           year_founded: team["intFormedYear"],
#           stadium_name: team["strStadium"],
#           stadium_location: team["strStadiumLocation"],
#           description: team["strDescriptionEN"]
#         )
#
#         get_team_players(team["idTeam"])
#       end
#     end
#     # response_string = RestClient.get('https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=' + id)
#     #
#     # response_hash = JSON.parse(response_string)
#     # response_hash['teams']
#   end
# end
############### GETS PLAYERS FOR TEAMS #############

# def get_team_players(team_id)
#
#   team_players = JSON.parse(RestClient.get('https://www.thesportsdb.com/api/v1/json/1/lookup_all_players.php?id=' + team_id))["player"]
#
#   if team_players != nil
#     team_players.each do |player|
#       Player.create(
#         team: Team.find_by(name: player["strTeam"]),
#         name: player["strPlayer"],
#         birthdate: player["dateBorn"],
#         date_signed: player["dateSigned"],
#         signing_status: player["strSigning"],
#         birth_location: player["strBirthLocation"],
#         player_description: player["strDescriptionEN"],
#         position: player["strPosition"],
#         height: player["strHeight"],
#         weight: player["strWeight"],
#         nationality: player["strNationality"]
#       )
#     end
#   end
# end
