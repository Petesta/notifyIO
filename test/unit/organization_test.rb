require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  test "organization genereates an api_key creation" do
    org = organizations(:one)
    assert_not_nil org.api_key
  end
end
