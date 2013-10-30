class Notification < ActiveRecord::Base
  belongs_to :organizations

  attr_accessible :message, :organization_id, :notification_type
end
