class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.string :status
      t.integer :people
      t.decimal :price
      t.timestamps null: false
    end
  end
end
