class CreateOtps < ActiveRecord::Migration
  def change
    create_table :otps do |t|
      t.string :code
      t.string :phone_no
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
