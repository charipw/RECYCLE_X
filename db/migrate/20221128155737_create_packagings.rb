class CreatePackagings < ActiveRecord::Migration[7.0]
  def change
    create_table :packagings do |t|
      t.text :category
      t.text :type
      t.string :eco_score
      t.integer :carbon_footprint

      t.timestamps
    end
  end
end
