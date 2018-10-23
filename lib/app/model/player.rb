class Player < ActiveRecord::Base
  belongs_to :team
  delegate :league, :to => :team


  def player_birthdate
  end

  def player_age
  end
  # 
  # def player_nationality
  # end
  #
  # def signing_status
  # end
  #
  # def player_description
  # end

  def tallest_player
  end

  def all_players_from_nationality
  end



end
