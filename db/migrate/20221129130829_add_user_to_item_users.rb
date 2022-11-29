class AddUserToItemUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :item_users, :user, null: false, foreign_key: true
  end
end
