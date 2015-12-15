class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :source, null: false, default: '0.0'
      t.string :destination, null: false, default: '0.0'
      t.decimal :distance, null: false, default: 0
      t.decimal :price, null: false, default: 5
      t.integer :status, null: false, default: 0
      t.references :user, index: true, foreign_key: true
      t.references :driver, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
