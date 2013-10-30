require 'test_helper'

class UserTest < ActiveSupport::TestCase
   test "the truth" do
     assert true
   end

  test "can't create user without email" do
    user_test = User.new
   assert !user_test.save, "Saved user without an email" 
  end

#  test "user should have an organization" do
#    user = User.first
#    assert_equal "NO", user.email
#    assert_equal 1, user.organizations.count, "This user should have one organization"
#  end
end
