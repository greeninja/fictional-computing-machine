class Setting < ApplicationRecord
  has_many :tick_types
  has_many :rat_types

  accepts_nested_attributes_for :tick_types, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :rat_types, allow_destroy: true, reject_if: :all_blank

  scope :sorted, lambda { order("settings.name ASC") }
end
