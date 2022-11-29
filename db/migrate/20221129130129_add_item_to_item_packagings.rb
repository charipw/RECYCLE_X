class AddItemToItemPackagings < ActiveRecord::Migration[7.0]
  def change
    add_reference :item_packagings, :item, null: false, foreign_key: true
  end
end
