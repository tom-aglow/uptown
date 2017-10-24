class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.integer :client_id
      t.string :action
      t.integer :eventable_id
      t.string :eventable_type

      t.timestamps
    end
  end
end
