class Setting < ApplicationRecord
  has_many :tick_types
  has_many :cross_types
  has_many :qa_settings
  has_many :qa_general_settings
  has_many :skills

  has_paper_trail

  validates_uniqueness_of :name

  accepts_nested_attributes_for :tick_types, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :cross_types, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :qa_settings, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :qa_general_settings, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :skills, allow_destroy: true, reject_if: :all_blank


  scope :sorted, lambda { order("settings.name ASC") }
end
