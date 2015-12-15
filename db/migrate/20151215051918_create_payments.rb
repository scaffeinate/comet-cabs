class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :holder_name, null: false, default: ''
      t.string :card_number, null: false, default: ''
      t.string :card_cvv, null: false, default: ''
      t.string :card_expiry, null: false, default: ''
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
