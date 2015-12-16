class AddCabTypeToDrivers < ActiveRecord::Migration
  def change
    add_reference :drivers, :cab_type, index: true, foreign_key: true, null: false, default: 0
  end
end
