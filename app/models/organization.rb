class Organization < ActiveRecord::Base
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :notifications

  attr_accessible :description, :name
  validates :name, uniqueness: true

  before_create :set_api_key

  def notifications_for_page(page_number)
    self.notifications.slice((page_number - 1) * 5, page_number * 5)
  end

  def filter_notifications(notification_type)
    notifications = self.notifications
    
    if notification_type == "success"
      notications.success
    elsif notification_type == "error"
      notifications.error
    elsif notification_type == "alert"
      notifications.alert
    end
  end

  private

  def set_api_key
    self.api_key = SecureRandom.hex(6)
  end
end
