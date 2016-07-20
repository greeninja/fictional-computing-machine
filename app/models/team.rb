class Team < ApplicationRecord
  
  has_many :user_teams
  has_many :users, :through => :user_teams
  
  scope :sorted, lambda { order("teams.id ASC") }

end
