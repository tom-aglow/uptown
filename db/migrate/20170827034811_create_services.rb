class CreateServices < ActiveRecord::Migration[5.1]
  def change
    create_table :services do |t|
      t.string 'name', limit: 30, null: false
      t.integer 'price', null: false
      t.timestamps
    end
  end
end
