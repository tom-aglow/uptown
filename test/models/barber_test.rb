require 'test_helper'

class BarberTest < ActiveSupport::TestCase
  test 'should not save barber without first and last name' do
    barber = Barber.new
    assert_not barber.save
  end
end
