class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.integer :building_id
      t.integer :number

      t.timestamps
    end
  end
end
