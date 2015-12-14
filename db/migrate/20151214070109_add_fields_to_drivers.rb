class AddFieldsToDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :license, :string, default: '', null: false
    add_column :drivers, :vehicle, :string, default: '', null: false
  end
end
