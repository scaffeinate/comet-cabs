class AddFieldsToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :source_name, :string
    add_column :bookings, :destination_name, :string
    add_column :bookings, :source_place_id, :string
    add_column :bookings, :destination_place_id, :string
  end
end
