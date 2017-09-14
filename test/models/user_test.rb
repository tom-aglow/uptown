require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save user without attributes' do
    user = User.new
    assert_not user.save
  end
end
