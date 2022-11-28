class AddBoroughToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :borough, null: false, foreign_key: true
  end
end
