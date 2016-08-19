class User < ApplicationRecord

  has_secure_password
  has_many :users
  has_many :rats
  has_many :ticks

  enum role: [:user, :supervisor, :team_leader, :junior_admin, :admin]
  after_initialize :set_default_role, :if => :new_record?

  scope :sorted, lambda { order("users.last_name ASC").order("users.first_name ASC") }

  EMAIL_REGEX = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}\Z/
  FORBIDDEN_USERNAMES = ['littlebopeep','humptydumpty','marymary','root']
  validates_presence_of :first_name
  validates_length_of :first_name, :maximum => 25
  validates_presence_of :last_name
  validates_length_of :last_name, :maximum => 50
  validates_presence_of :username
  validates_length_of :username, :within => 5..25
  validates_uniqueness_of :username
  validates_presence_of :email
  validates_length_of :email, :maximum => 100
  validates_format_of :email, :with => EMAIL_REGEX
  validates_confirmation_of :email

  #validates :username_is_allowed

  def username_is_allowed
    if FORBIDDEN_USERNAMES.include?(username)
      errors.add(:username, "has been restricted from use")
    end
  end

  def name
    "#{first_name} #{last_name}"
  end

  def set_default_role
    self.role ||= :user
  end

end
