class Team < ApplicationRecord
  
  has_many :users
  has_many :ticks, through: :users
  has_many :rats, through: :users
  scope :sorted, lambda { order("teams.id ASC") }

end
