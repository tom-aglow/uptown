require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  test 'should not save clients without attributes' do
    client = Client.new
    assert_not client.save
  end
end
