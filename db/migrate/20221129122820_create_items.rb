class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :eco_score
      t.integer :carbon_footprint
      t.text :name
      t.string :barcode

      t.timestamps
    end
  end
end
