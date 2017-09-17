require 'test_helper'

class TestimonialTest < ActiveSupport::TestCase
  test 'should not save testimonial without attributes' do
    testimonial = Testimonial.new
    assert_not testimonial.save
  end
end
