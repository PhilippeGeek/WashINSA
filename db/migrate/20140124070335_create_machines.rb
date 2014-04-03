class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :name
      t.boolean :blocked
      t.integer :building_id

      t.timestamps
    end
  end
end
