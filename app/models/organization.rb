class Organization < ActiveRecord::Base
	has_many :subscriptions
	has_many :users, through: :subscriptions
  has_many :notifications

	attr_accessible :description, :name, :subscription_id
  validates :name, uniqueness: true

  before_create :set_api_key

  private
  def set_api_key
    self.api_key = SecureRandom.hex(6)
  end
end
