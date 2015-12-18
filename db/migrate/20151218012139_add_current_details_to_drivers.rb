class AddCurrentDetailsToDrivers < ActiveRecord::Migration
  def change
    add_column :drivers, :latitude, :float, null: false, default: 0.0
    add_column :drivers, :longitude, :float, null: false, default: 0.0
    add_column :drivers, :available, :boolean, null: false, default: true
  end
end
