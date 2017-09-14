require 'application_system_test_case'

class ReservationsTest < ApplicationSystemTestCase
  test 'making a reservation' do
    visit reservation_url

    fill_in 'shift[barber_id]', with: '1'
    fill_in 'shift[date]', with: '2017-09-01'
    fill_in 'shift[time]', with: '17:00:00'
    fill_in 'requisition[service_id]', with: '1'
    fill_in 'client[full_name]', with: 'tom'
    fill_in 'client[phone]', with: '111.111.1111'
    fill_in 'client[email]', with: 'tom@ohhhh.me'

    click_button 'commit'

    expect(page).to have_content 'We\'ve reserved a seat for you'
  end
end
