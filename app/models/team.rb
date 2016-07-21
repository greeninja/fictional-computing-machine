class Team < ApplicationRecord
  
  has_many :users
  scope :sorted, lambda { order("teams.id ASC") }

end
