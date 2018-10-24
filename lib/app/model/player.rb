require 'date'

class Player < ActiveRecord::Base
  belongs_to :team
  delegate :league, :to => :team


  def player_age
    date1 = DateTime.parse(self.birthdate).to_date
    date2 = Time.now.strftime("%Y-%m-%d")
    today = date2.to_date
    ((today - date1)/365).to_f.round(0)
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

  def self.tallest_player #make a conditional
    tallest = self.all.sort_by{|player|
      player.height.to_f}[-1]
    tall_players_arr = Player.where(height: tallest.height).map {|player| player.name}
    if tall_players_arr.count > 0
    "The tallest players on record are #{self.oxford(tall_players_arr)} with a height of #{tallest.height} m or #{(tallest.height.to_f * 3.3).round(2)} ft"
    else
    "The tallest player on record is #{self.oxford(tall_players_arr)} with a height of #{tallest.height} m or #{(tallest.height.to_f * 3.3).round(2)} ft"
    end
  end

  def self.shortest_player #eliminate height = 0
   self.all.each do |player|
      if player.height.to_f > 0 && != nil
      short = self.all.sort_by{|player| player.height.to_f}
      binding.pry
      end
    end

    shortest_players = short.map do |player|
      if player.height == "" || player.height == "0"
        player.delete!
      else
        player.height.to_f
      end
    end
    shortest_players

    # shortest_no_zeroes = shortest.map do |player|
    #   if player.height.to_f != 0.0 || player.height.to_f != nil
    #     player.height.to_f
    #   end
    # end
    binding.pry
    short_players_arr = Player.where(height: shortest.height).map {|player| player.name}
    "The shortest player(s) on record is(are) #{self.oxford(short_players_arr)} with a height of #{shortest.height} m or #{(shortest.height.to_f * 3.3).round(2)} ft"
  end

  def self.oldest_player #invalid date
    oldest_player = self.all.sort_by {|player| player.player_age}[-1]
    old_player_arr = Player.where(birthdate: oldest_player.birthdate).map {|player| player.name}
    if old_player_arr.count > 1
      "#{self.oxford(old_player_arr)} are the oldest players. They are #{oldest_player.player_age} years old."
    else
      "#{old_player_arr.join(" ")} is the oldest player. He is #{oldest_player.player_age} years old."
    end
  end

  def self.youngest_player #invalid date
    youngest_player = self.all.sort_by {|player| player.player_age}[0]
    young_player_arr = Player.where(birthdate: youngest_player.birthdate).map {|player| player.name}
    if young_player_arr.count > 1
      "#{self.oxford(young_player_arr)} are the youngest players. They are #{youngest_player.player_age} years old."
    else
      "#{young_player_arr.join(" ")} is the youngest player. He is #{youngest_player.player_age} years old."
    end
  end

  def self.all_players_from_nation(nation)
    players = self.all.select {|player| player.nationality == nation}.collect {|player| player.name}
    if players.count >1
      "The players from #{nation} are #{self.oxford(players)}."
    else
      "#{player} is the only player from #{nation}."
    end
  end

  def player_time_with_team
    date1 = DateTime.parse(self.date_signed).to_date
    date2 = Time.now.strftime("%Y-%m-%d")
    today = date2.to_date
    "#{((today - date1)/365).to_f.round(0)} years"
  end

end
