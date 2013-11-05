class Organization < ActiveRecord::Base
  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :notifications

  attr_accessible :description, :name, :subscription_id
  validates :name, uniqueness: true

  before_create :set_api_key

  def notifications_for_page(page_number)
    self.notifications.slice((page_number - 1) * 5, page_number * 5)
  end

  private

  def set_api_key
    self.api_key = SecureRandom.hex(6)
  end
end
