class AddPasswordSetFieldToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_password_set, :boolean, null: false, default: false
    rename_column :users, :profile_complete, :is_card_info_set
  end
end
