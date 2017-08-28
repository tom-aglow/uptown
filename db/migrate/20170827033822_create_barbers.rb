class CreateBarbers < ActiveRecord::Migration[5.1]
  def change
    create_table :barbers do |t|
      t.string 'first_name', limit: 30, null: false
      t.string 'last_name', limit: 30, null: false
      t.string 'avatar', limit: 100, null: false, default: 'default.jpg'
      t.timestamps
    end
  end
end
