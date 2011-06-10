require 'test_helper'

class UserTest < ActiveSupport::TestCase
    fixtures :users

    test "should create user" do
        # user = User.new(:name => 'VvDPzZ', :email => "vvdpzz@gmail.com", :password => "jijizhudong", :password_confirmation => "jijizhudong")
        user = users(:one)
        assert user.save
    end
end
