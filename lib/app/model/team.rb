require 'date'

class Team < ActiveRecord::Base
  has_many :players
  belongs_to :league

  def get_team_roster
    self.players.collect {|player| player.name}
  end

  def player_count
    self.get_team_roster.count
  end

  def team_age
    date1 = self.year_founded.to_i
    today = Time.now.strftime("%Y").to_i
    today - date1
  end

  def self.oxford(arr)
    if arr.count == 1
      arr.join
    elsif arr.count == 2
      arr.join(" and ")
    elsif arr.length >= 3
      arr[0..arr.count - 2].join(", ") + ", and " + arr[-1]
    end
  end

  def self.oldest_team
    oldest_team = self.all.sort_by {|team| team.team_age}[-1]
    old_team_arr = Team.where(year_founded: oldest_team.year_founded).map {|team| team.name}
    if old_team_arr.count > 1
      "#{self.oxford(old_team_arr)} are the oldest teams. They were founded in #{oldest_team.year_founded}."
    else
      "#{old_team_arr.join(" ")} is the oldest team. It was founded in #{oldest_team.year_founded}."
    end
  end

  def self.youngest_team
    youngest_team = self.all.sort_by {|team| team.team_age}[0]
    young_team_arr = Team.where(year_founded: youngest_team.year_founded).map {|team| team.name}
    if young_team_arr.count > 1
      "#{self.oxford(young_team_arr)} are the youngest teams. They were founded in #{youngest_team.year_founded}."
    else
      "#{young_team_arr.join(" ")} is the youngest team. It was founded in #{youngest_team.year_founded}."
    end
  end

  # def contact_info
  #
  # end



end
