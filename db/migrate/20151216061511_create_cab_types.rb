class CreateCabTypes < ActiveRecord::Migration
  def change
    create_table :cab_types do |t|
      t.decimal :base_fare, null: false, default: 5.0
      t.integer :number_of_persons, null: false, default: 4
      t.string :name, null: false, default: ''

      t.timestamps null: false
    end
  end
end
