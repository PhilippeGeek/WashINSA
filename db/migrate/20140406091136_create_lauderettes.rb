class CreateLauderettes < ActiveRecord::Migration
  def change
    create_table :lauderettes do |t|
      t.string :name
      t.text :notes
      t.text :description
      t.boolean :opened

      t.timestamps
    end
    change_table :machines do |t|
      t.remove :building_id
      t.integer :laundrette_id
    end
    change_table :buildings do |t|
      t.integer :laundrette_id
    end
  end
end
