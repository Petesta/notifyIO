require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "new notification" do
    notification = Notification.new
    notification.message = "Test notification"
    notification.notification_type = "SEVERE"
    org = Organization.all
    notification.organization_id = org.first.id
    assert notification.save, "Save it"
  end
end
