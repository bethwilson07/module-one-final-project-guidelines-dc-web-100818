class Player < ActiveRecord::Base
  belongs_to :team
  #delegate ?????
end
