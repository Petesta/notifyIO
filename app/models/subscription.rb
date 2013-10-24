class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :organization

  attr_accessible :organization_id, :user_id
end
