class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :machine_id
      t.integer :user_id
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end
