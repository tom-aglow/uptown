# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ___ METHODS ___

def get_random_record_id(model)
  model.limit(1).order("RAND()").first.id
end


# ___ SEEDS ___

# === USERS ===

User.create(username: 'admin', email: 'tom@ohhhh.me', password: 'qwerty')


# === BARBERS ===

barbers_num = 5

barbers_num.times do |i|
  Barber.create(first_name: Faker::Name.first_name,
                last_name: Faker::Name.last_name,
                avatar: "barber_#{i + 1}.jpg"
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
    'Kids Cut' => 25,
}

services.each do |name, price|
  Service.create(name: name, price: price)
end



# === CLIENTS ===

20.times do
  Client.create(full_name: Faker::Name.name,
                email: Faker::Internet.free_email,
                phone: Faker::Number.number(10)
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

  7.times do |j|
    cur_date = (j + 1).days.from_now
    cur_shift = shifts[rand(shifts.length)]

    cur_shift.call(i + 1, cur_date)
  end

  # --- ORDERS ---

  20.times do
    shift_record = Shift.where(barber_id: i + 1).limit(1).order("RAND()").first

    order_date = Time.parse(shift_record.date.to_s)

    order = Order.create(client_id: 1 + rand(19),
                         service_id: 1 + rand(6),
                         status: 'booked',
                         created_at: order_date,
                         updated_at: order_date
    )

    shift_record.update(order_id: order.id, is_free: false)
  end
end


# === TESTIMONIALS ===

20.times do

  order_date = Faker::Time.between(14.days.ago, 5.days.ago)
  service_date = Date.parse((order_date + 3.days).to_s)
  testimonial_date = order_date + 4.days


  order = Order.create(client_id: Client.limit(1).order("RAND()").first.id,
                      service_id: Service.limit(1).order("RAND()").first.id,
                      status: 'paid',
                      created_at: order_date,
                      updated_at: order_date
  )

  Shift.create(date: service_date,
               time: '17:00:00',
               barber_id: get_random_record_id(Barber),
               is_free: false,
               order_id: order.id
  )

  Testimonial.create(client_id: order.client_id,
                 order_id:order.id,
                 body: Faker::Hipster.paragraph(1),
                 grade: rand(5) + 1,
                 created_at: testimonial_date,
                 updated_at: testimonial_date
  )
end