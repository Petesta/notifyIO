class Organization < ActiveRecord::Base
	has_many :subscriptions
	has_many :users, through: :subscriptions
  has_many :notifications

	attr_accessible :description, :name, :subscription_id
    validates :name, uniqueness: true
end
