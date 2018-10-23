class League < ActiveRecord::Base
  has_many :teams
  has_many :players, through: :teams


def get_list_of_teams
  self.teams.collect {|team| team.name}
end

def player_count
  self.players.count
end

# def year_founded
# end
#
# def league_description
# end

end
