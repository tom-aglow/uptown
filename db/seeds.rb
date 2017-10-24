# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ::: METHODS :::

def get_random_record_id(model)
  model.limit(1).order("RANDOM()").first.id
end


# ::: SEEDS :::

# === USERS ===

User.create(username: 'admin', email: 'tom@ohhhh.me', password: 'qwerty')


# === BARBERS ===

barbers_num = 5

barbers_num.times do |i|
  Barber.create(first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                avatar: "avatar_#{i + 1}.jpg"
  )
end


# === SERVICES ===

services = {
    'Haircut' => 35,
    'Buzzcut' => 20,
    'Beard Trim' => 15,
    'Haircut & Beard Trim' => 45,
    'Shaves' => 40,
    'Student / Senior Cuts' => 30,
    'Kids Cut' => 25
}

services.each do |name, price|
  Service.create(name: name, price: price)
end



# === CLIENTS ===
20.times do
  Client.create(full_name: Faker::Name.name,
                email: Faker::Internet.free_email,
                phone: [Faker::Number.number(3), Faker::Number.number(3), Faker::Number.number(4)].join('.')
  )
end

# === SHIFTS: LAMBDAS ===

shift = lambda do |s_barber, s_date, s_start, s_end|
  hours = s_end - s_start + 1

  hours.times do |i|
    Shift.create(date: s_date,
                 time: (s_start + i).to_s + ':00:00',
                 barber_id: s_barber,
                 is_free: true
    )
  end
end

morning_shift = lambda { |s_barber, s_date| shift.call(s_barber, s_date, 10, 14)}
afternoon_shift = lambda { |s_barber, s_date| shift.call(s_barber, s_date, 12, 17)}
evening_shift = lambda { |s_barber, s_date| shift.call(s_barber, s_date, 15, 19)}
all_day_shift = lambda { |s_barber, s_date| shift.call(s_barber, s_date, 12, 19)}
day_off = lambda { |s_barber, s_date| }

shifts = [morning_shift, afternoon_shift, evening_shift, all_day_shift, day_off]


# === SHIFTS AND ORDER SEEDING ===

barbers_num.times do |i|

  # --- SHIFTS ---

  20.times do |j|
    cur_date = (j).days.from_now
    cur_shift = shifts[rand(shifts.length)]

    cur_shift.call(i + 1, cur_date)
  end

  # --- ORDERS ---

  100.times do
    shift_record = Shift.where(barber_id: i + 1).limit(1).order("RANDOM()").first

    req_date = Faker::Time.between(10.days.ago, 1.days.ago)

		client_id = get_random_record_id(Client)

    req_record = Requisition.create(client_id: client_id,
                                    service_id: 1 + rand(6),
                                    shift_id: shift_record.id,
                                    status: 'booked',
                                    created_at: req_date,
                                    updated_at: req_date
    )

    shift_record.update_attributes(is_free: false)

		# creating activity
		Client.where(id: client_id).first.activities.create(
			action: 'booking',
			eventable: req_record,
			created_at: req_date,
			updated_at: req_date
		)
  end
end


# === TESTIMONIALS ===

20.times do

  # setting up parameters
  req_date = Faker::Time.between(14.days.ago, 4.days.ago)
  service_date = Date.parse((req_date + 3.days).to_s)
  service_time = rand(10...19).to_s + ':00:00'
  barber_id_rand = get_random_record_id(Barber)
  testimonial_date = req_date + 4.days

  # creating or updating shift record
  shift_record = Shift.find_or_initialize_by(date: service_date, time: service_time, barber_id: barber_id_rand)
  shift_record.update_attributes(is_free: false)

  # creating an order record
	client_id = get_random_record_id(Client)

	req_record = Requisition.create(client_id: client_id,
                                  service_id: get_random_record_id(Service),
                                  shift_id: shift_record.id,
                                  status: 'paid',
                                  created_at: req_date,
                                  updated_at: req_date
  )

  # creating testimonial record
  test_record = Testimonial.create(requisition_id: req_record.id,
                     body: Faker::Hipster.paragraph(1),
                     grade: rand(4..5),
                     created_at: testimonial_date,
                     updated_at: testimonial_date
  )

	# creating activities
	Client.where(id: client_id).first.activities.create(
		action: 'booking',
		eventable: req_record,
		created_at: req_date,
		updated_at: req_date
	)

	Client.where(id: client_id).first.activities.create(
		action: 'testimonial',
		eventable: test_record,
		created_at: testimonial_date,
		updated_at: testimonial_date
	)
end
