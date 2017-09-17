require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  test 'should not save service without attributes' do
    service = Service.new
    assert_not service.save
  end
end
