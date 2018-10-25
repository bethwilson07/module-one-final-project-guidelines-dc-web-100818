require 'date'

class Team < ActiveRecord::Base
  has_many :players
  belongs_to :league

  def get_team_roster #works
    self.players.collect {|player| player.name}
  end

  def player_count #works
    self.get_team_roster.count
  end

  def team_age #works
    date1 = self.year_founded.to_i
    today = Time.now.strftime("%Y").to_i
    "#{today - date1} years"
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

  def oxford(arr)
    if arr.count == 1
      arr.join
    elsif arr.count == 2
      arr.join(" and ")
    elsif arr.length >= 3
      arr[0..arr.count - 2].join(", ") + ", and " + arr[-1]
    end
  end

  # def self.num_digits
  #  Math.log10(self).to_i + 1
  # end

  def self.refined_age_data #works enough
    nonzero_ages = self.all.select {|team| team.year_founded.to_i != 0}
    nonzero_ages
  end

  def self.oldest #works
    oldest_team = self.refined_age_data.sort_by {|team| team.team_age}[-3]
    old_team_arr = Team.where(year_founded: oldest_team.year_founded).map {|team| team.name}
    if old_team_arr.count > 1
      "#{self.oxford(old_team_arr)} are the oldest teams according to our records. They were founded in #{oldest_team.year_founded}."
    else
      "#{old_team_arr.join(" ")} is the oldest team on our record. It was founded in #{oldest_team.year_founded}."
    end
  end

  def self.youngest #works
    youngest_team = self.all.sort_by {|team| team.team_age}[0]
    young_team_arr = Team.where(year_founded: youngest_team.year_founded).map {|team| team.name}
    if young_team_arr.count > 1
      "#{self.oxford(young_team_arr)} are the youngest teams. They were founded in #{youngest_team.year_founded}."
    else
      "#{young_team_arr.join(" ")} is the youngest team on our record. It was founded in #{youngest_team.year_founded}."
    end
  end

  def youngest_player #works
    young_player = self.players.sort_by {|player| player.age }[0]
    young_players = self.players.select {|player| player.age == young_player.age}.collect {|player| player.name}
    if young_players.count > 1
      "#{oxford(young_players)} are the youngest players. They are #{young_player.age} years old."
    else
      "#{young_players.join(" ")} is the youngest player. He is #{young_player.age} years old."
    end
  end

  def oldest_player #works
    old_player = self.players.sort_by {|player| player.age }[-1]
    old_players = self.players.select {|player| player.age == old_player.age}.collect {|player| player.name}
    if old_players.count > 1
      "#{oxford(old_players)} are the oldest players. They are #{old_player.age} years old."
    else
      "#{old_players.join(" ")} is the oldest player. He is #{old_player.age} years old."
    end
  end

  # def contact_info
  #
  # end



end
