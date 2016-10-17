require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @admin = users(:admin_user)
  end
  test "it_responds_to_first_name" do
  	assert_respond_to @admin, :first_name
  end
  test "it_responds_to_last_name" do
  	assert_respond_to @admin, :last_name
  end
  test "it_responds_to_email" do
  	assert_respond_to @admin, :email
  end
  test "it_responds_to_phone" do
  	assert_respond_to @admin, :phone
  end
  test "it_responds_to_role" do
  	assert_respond_to @admin, :role
  end
  test "it_responds_to_address" do
  	assert_respond_to @admin, :address
  end
  test "it_responds_to_city" do
  	assert_respond_to @admin, :city
  end
  test "it_responds_to_state" do
  	assert_respond_to @admin, :state
  end
  test "it_responds_to_zipcode" do
  	assert_respond_to @admin, :zipcode
  end
  test "role_returns_string" do
    assert_equal "admin", @admin.role
  end
  test "user_is_instance_of_user" do
  	assert_instance_of User, @admin
  end

end
