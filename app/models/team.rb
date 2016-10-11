class Team < ApplicationRecord

  has_many :agents
  has_many :ticks, through: :agents
  has_many :crosses, through: :agents
  has_many :tickets, through: :agents
  has_many :users

  has_paper_trail

  scope :sorted, lambda { order("teams.id ASC") }

end
