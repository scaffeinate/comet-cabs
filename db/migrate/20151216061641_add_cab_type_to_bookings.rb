class AddCabTypeToBookings < ActiveRecord::Migration
  def change
    add_reference :bookings, :cab_type, index: true, foreign_key: true, null: false, default: 0
  end
end
