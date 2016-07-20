class Team < ApplicationRecord
  
  has_many :user_teams
  has_many :users
  
  # has_and_belongs_to_many :users

  scope :sorted, lambda { order("teams.id ASC") }

end
