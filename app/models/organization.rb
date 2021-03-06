class Organization < ActiveRecord::Base
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :notifications

  attr_accessible :description, :name
  validates :name, uniqueness: true

  before_create :set_api_key

  def notifications_for_page(page_number)
    self.notifications.limit(5).offset((page_number - 1) * 5)
  end

  def filter_notifications(notification_type)
    self.notifications.select { |n| n.notification_type == notification_type }
  end

  private

  def set_api_key
    self.api_key = SecureRandom.hex(6)
  end
end
