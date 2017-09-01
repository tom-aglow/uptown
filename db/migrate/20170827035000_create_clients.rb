class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string 'full_name', limit: 50, null: false
      t.string 'email', limit: 50, null: false
      t.string 'phone', limit: 11, null: false
      t.timestamps
    end

    add_index :clients, :email, unique: true
  end
end
