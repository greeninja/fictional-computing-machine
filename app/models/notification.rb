class Notification < ApplicationRecord
  scope :sorted, lambda { order("notifications.created_at ASC") }
end
