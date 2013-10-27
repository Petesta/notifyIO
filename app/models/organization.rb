class Organization < ActiveRecord::Base
	has_many :subscriptions
	has_many :users, through: :subscriptions

	attr_accessible :description, :name, :subscription_id
end
