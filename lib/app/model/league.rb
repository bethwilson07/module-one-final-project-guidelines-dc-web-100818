class League < ActiveRecord::Base
  has_many :teams
  has_many :players, through: :teams

def league_age
  date1 = self.year_founded.to_i
  today = Time.now.strftime("%Y").to_i
  today - date1
end

def league_size
  self.teams.count
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

def self.oldest_league
  oldest_league = self.all.sort_by {|league| league.league_age}[-1]
  old_league_arr = League.where(year_founded: oldest_league.year_founded).map {|league| league.name}
  if old_league_arr.count > 1
    "#{self.oxford(old_league_arr)} are the oldest leagues. They were founded in #{oldest_league.year_founded}."
  else
    "#{old_league_arr.join(" ")} is the oldest league on our record. It was founded in #{oldest_league.year_founded}."
  end
end

def self.youngest_league
  youngest_league = self.all.sort_by {|league| league.league_age}[0]
  young_league_arr = League.where(year_founded: youngest_league.year_founded).map {|league| league.name}
  if young_league_arr.count > 1
    "#{self.oxford(young_league_arr)} are the youngest leagues. They were founded in #{youngest_league.year_founded}."
  else
    "#{young_league_arr.join(" ")} is the youngest league on our record. It was founded in #{youngest_league.year_founded}."
  end
end

def self.largest_league
  largest = self.all.sort_by {|league| league.league_size }[-1]
  "The largest league is #{largest.name} with #{largest.league_size} teams."
end

def self.smallest_league
  smallest = self.all.sort_by {|league| league.league_size }[0]
  "The smallest league is #{smallest.name} with #{smallest.league_size} teams."
end

def oldest_team
  oldest_team = self.teams.sort_by{|team| team.team_age}[-1]
  old_team_arr = self.teams.select {|team| team.team_age == oldest_team.team_age}.collect{|team| team.name}
  if old_team_arr.count > 1
    "#{oxford(old_team_arr)} are the oldest teams in the league. They were founded in #{oldest_team.year_founded}."
  else
    "The oldest team in the league is #{oldest_team.name}. It was founded in #{oldest_team.year_founded}."
  end
end

def youngest_team
  youngest_team = self.teams.sort_by{|team| team.team_age}[0]
  young_team_arr = self.teams.select {|team| team.team_age == youngest_team.team_age}.collect{|team| team.name}
  if young_team_arr.count > 1
    "#{oxford(young_team_arr)} are the youngest teams in the league. They were founded in #{youngest_team.year_founded}."
  else
    "The youngest team in the league is #{youngest_team.name}. It was founded in #{youngest_team.year_founded}."
  end
end

def get_list_of_teams
  self.teams.collect {|team| team.name}
end

def player_count
  self.players.count
end

def get_managers_in_league
  self.teams.collect {|team| team.manager }.uniq
end


end
