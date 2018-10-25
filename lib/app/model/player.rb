require 'date'

class Player < ActiveRecord::Base
  belongs_to :team
  delegate :league, :to => :team

  # def validate_date(string)
  #   format_ok = string.match(/\d{4}-\d{2}-\d{2}/)
  #   parseable = Date.strptime(string, '%Y-%m-%d') rescue false
  #
  #   if string == 'never' || format_ok && parseable
  #     puts "true"
  #   else
  #     puts "false"
  #   end
  # end

  def age #works on players with valid date
    if self.birthdate != nil
      player_year = self.birthdate[0...4].to_i
      Time.now.year - player_year
    else
      "invalid date"
    end
  end

  # def self.player_age
  #  date1 = DateTime.parse(self.birthdate).to_date
  #  date2 = Time.now.strftime("%Y-%m-%d")
  #  today = date2.to_date
  #  ((today - date1)/365).to_f.round(0)
  # end

  def self.oxford(arr)
    if arr.count == 1
      arr.join
    elsif arr.count == 2
      arr.join(" and ")
    elsif arr.length >= 3
      arr[0..arr.count - 2].join(", ") + ", and " + arr[-1]
    end
  end

  def self.refined_height_data #works enough
    nonzero_heights = self.all.select {|player| player.height.to_s.ends_with?("m") && !player.height.to_s.include?("cm")}
    refined = nonzero_heights.select {|player| !player.height.to_s.starts_with?("(") && !player.height.to_s.include?(",")}
    refined
  end

  def self.tallest_player #works
    tallest = self.refined_height_data.sort_by {|player| player.height.to_f}[-1]
    tall_players_arr = Player.where(height: tallest.height).map {|player| player.name}
    if tall_players_arr.count > 1
    "The tallest players on our record are #{self.oxford(tall_players_arr)} with a height of #{tallest.height.to_f} m or #{(tallest.height.to_f * 3.3).round(2)} ft"
    else
    "The tallest player on our record is #{self.oxford(tall_players_arr)} with a height of #{tallest.height.to_f} m or #{(tallest.height.to_f * 3.3).round(2)} ft"
    end
  end

  def self.shortest_player #works
   shortest = self.refined_height_data.sort_by {|player| player.height.to_f}[0]
   short_players_arr = Player.where(height: shortest.height).map {|player| player.name}
   if short_players_arr.count > 1
    "The shortest players on our record are #{self.oxford(short_players_arr)} with a height of #{shortest.height.to_f} m or #{(shortest.height.to_f * 3.3).round(2)} ft"
   else
    "The shortest player on our record is #{self.oxford(short_players_arr)} with a height of #{shortest.height.to_f} m or #{(shortest.height.to_f * 3.3).round(2)} ft"
   end
  end

  def self.refined_birthdate_data
    self.all.select { |player| !player.birthdate.nil? && Date.valid_civil?(player.birthdate[0..3].to_i, player.birthdate[5..6].to_i, player.birthdate[8..9].to_i) }

    #!player.birthdate.to_s.nil? && player.birthdate.to_s != ""}
  end

  def self.oldest
    oldest_player = self.refined_birthdate_data.sort_by{|player| player.age}[-1]

    # year = oldest_playerplayer.birthdate[0..3].to_i
    # month = oldest_player.birthdate[5..6].to_i
    # day = player.birthdate[8..9].to_i

    # bday = Date.strptime(oldest_player.birthdate, '%Y-%m-%d')
    # age = (DateTime.now.to_date - bday).to_i/365

    "#{oldest_player.name} is the oldest player. He is #{oldest_player.age} years old."

    # binding.pry
    # ''
    # old_player_arr = Player.where(birthdate: oldest_player.birthdate).map {|player| player.name}
    # if old_player_arr.count > 1
    #   "#{self.oxford(old_player_arr)} are the oldest players. They are #{oldest_player.player_age} years old."
    # else
    #   "#{old_player_arr.join(" ")} is the oldest player. He is #{oldest_player.player_age} years old."
    # end
  end

  def self.youngest
    youngest_player = self.refined_birthdate_data.sort_by{|player| player.age}[0]

    # bday = Date.strptime(youngest_player.birthdate, '%Y-%m-%d')
    # age = (DateTime.now.to_date - bday).to_i/365

    "#{youngest_player.name} is the oldest player. He is #{youngest_player.age} years old."

    # youngest_player = self.all.sort_by {|player| player.player_age}[0]
    # young_player_arr = Player.where(birthdate: youngest_player.birthdate).map {|player| player.name}
    # if young_player_arr.count > 1
    #   "#{self.oxford(young_player_arr)} are the youngest players. They are #{youngest_player.player_age} years old."
    # else
    #   "#{young_player_arr.join(" ")} is the youngest player. He is #{youngest_player.player_age} years old."
    # end
  end

  def self.all_players_from_nation(nation) #works
    players = self.all.select {|player| player.nationality == nation}.collect {|player| player.name}
    if players.count >1
      "The players from #{nation} are #{self.oxford(players)}."
    else
      "#{player} is the only player from #{nation}."
    end
  end

  def player_time_with_team #works if date_signed is valid
    date1 = DateTime.parse(self.date_signed).to_date
    date2 = Time.now.strftime("%Y-%m-%d")
    today = date2.to_date
    "#{((today - date1)/365).to_f.round(0)} years"
  end

end
