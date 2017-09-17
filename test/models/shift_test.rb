require 'test_helper'

class ShiftTest < ActiveSupport::TestCase
  test 'should not save shift without attributes' do
    shift = Shift.new
    assert_not shift.save
  end
end
