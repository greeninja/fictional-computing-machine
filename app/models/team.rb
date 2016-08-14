class Team < ApplicationRecord

  has_many :agents
  has_many :ticks, through: :agents
  has_many :rats, through: :agents
  scope :sorted, lambda { order("teams.id ASC") }

end
