require 'test_helper'

class RequisitionTest < ActiveSupport::TestCase
  test 'should not save requisition without attributes' do
    req = Requisition.new
    assert_not req.save
  end
end
