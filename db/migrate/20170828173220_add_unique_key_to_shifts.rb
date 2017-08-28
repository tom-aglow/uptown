class AddUniqueKeyToShifts < ActiveRecord::Migration[5.1]
  def change
    add_index :shifts, [:date, :time, :barber_id], unique: true
  end
end
