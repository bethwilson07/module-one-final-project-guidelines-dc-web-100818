class Team < ActiveRecord::Base
  has_many :players
  belongs_to :league


  def get_team_roster
    self.players.collect {|player| player.name}
  end

  def player_count
    self.get_team_roster.count
  end

  # def year_founded
  # end
  #
  # def team_manager
  # end
  #
  # def team_description
  # end

  # def stadium_location
  # end

  def contact_info
  end



end
