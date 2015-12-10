class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :uid
      t.string :provider
      t.string :oauth_token
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
