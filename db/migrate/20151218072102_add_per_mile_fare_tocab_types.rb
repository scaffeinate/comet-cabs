class AddPerMileFareTocabTypes < ActiveRecord::Migration
  def change
    add_column :cab_types, :per_mile_fare, :float, null: false, default: 1.0
  end
end
