class AddLaundretteToUsers < ActiveRecord::Migration
  def change
    add_column :users, :laundrette_id, :integer
  end
end
