class AddPackagingToItemPackagings < ActiveRecord::Migration[7.0]
  def change
    add_reference :item_packagings, :packaging, null: false, foreign_key: true
  end
end
