class User < ApplicationRecord

  belongs_to :team
  has_many :rats
  has_many :ticks

  attr_reader :date_from, :date_to

  accepts_nested_attributes_for :rats, :ticks, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :ticks, reject_if: :all_blank
  scope :sorted, lambda { order("users.customid ASC") }
  scope :uniq_team_id, lambda { select('DISTINCT(team_id)') }

  def initialize(params)
    params ||= {}
    @date_from = parsed_date(params[:date_from], Date.today.beginning_of_month)
    @date_to = parsed_date(params[:date_to], Date.today.end_of_month)
  end

  private

  def parsed_date(date_string, default)
    Date.parse(date_string)
  rescue ArgumentError, TypeError
    default
  end


end
