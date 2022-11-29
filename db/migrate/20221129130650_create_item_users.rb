class CreateItemUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :item_users do |t|

      t.timestamps
    end
  end
end
