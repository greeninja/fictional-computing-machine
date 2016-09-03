class Setting < ApplicationRecord
  has_many :tick_types
  has_many :rat_types
  has_many :qa_settings

  has_paper_trail

  accepts_nested_attributes_for :tick_types, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :rat_types, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :qa_settings, allow_destroy: true, reject_if: :all_blank

  scope :sorted, lambda { order("settings.name ASC") }
end
