class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string 'username', limit: 30, null: false
      t.string 'email', default: '', null: false
      t.string 'password_digest', null: false
      t.timestamps
    end

    add_index :users, :username, unique: true
  end
end
