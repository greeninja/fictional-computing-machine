class User < ApplicationRecord
  has_many :rats
  has_many :ticks
  # belongs_to :team
  has_many :user_teams
  has_many :teams, :through => :user_teams
  
  # has_and_belongs_to_many :teams

  accepts_nested_attributes_for :rats, :ticks, allow_destroy: true, reject_if: :all_blank 
  accepts_nested_attributes_for :ticks, reject_if: :all_blank
  scope :sorted, lambda { order("users.name ASC") }
  scope :sorted_by_id, lambda { order("users.id ASC") }
end
