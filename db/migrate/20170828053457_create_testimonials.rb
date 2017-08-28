class CreateTestimonials < ActiveRecord::Migration[5.1]
  def change
    create_table :testimonials do |t|
      t.bigint 'client_id', null: false
      t.bigint 'order_id', null: false
      t.text 'body', null: false
      t.integer 'grade', default: 1, null: false
      t.timestamps
    end

    add_index :testimonials, [:client_id, :order_id]

    add_foreign_key :testimonials, :clients
    add_foreign_key :testimonials, :orders
  end
end
