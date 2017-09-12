class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses do |t|
      t.bigint 'user_id', null: false
      t.text 'body', null: false
      t.timestamps
    end

    add_index :statuses, :user_id

    add_foreign_key :statuses, :users
  end
end
